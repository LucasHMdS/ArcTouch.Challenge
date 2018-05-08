//
//  MoviesListPresenter.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import Foundation

protocol MoviesListPresenterDelegate {
    func setMovies(_ movies: [Movie])
    func noMovies(message: String, last: Bool)
    func reloadMovies(_ movies: [Movie])
    func displayError(message: String)
    func addMovies(_ movies: [Movie], last: Bool)
}

class MoviesListPresenter {
    // MARK: - View 'Reference'
    var view: MoviesListPresenterDelegate
    
    // MARK: - Variables
    var movies: [Movie]?
    var genres: [Genre]?
    var page: Int = 1
    var serviceRunning: Bool = false
    var isReloadCall: Bool = false
    var searchMode: Bool = false
    var searchString: String = ""
    
    // MARK: - Initializers
    init(_ delegate: MoviesListPresenterDelegate) {
        self.view = delegate
    }
    
    // MARK: - Functions
    func getUpcomingMovies() {
        guard (!self.serviceRunning) else {
            return
        }
        
        self.serviceRunning = true
        
        if (genres != nil) {
            self.runGetUpcoming()
        } else {
            GenresService.getMovieList() {
                (genresListDTO, error) in
                
                if let genresListDTO = genresListDTO {
                    var genres = [Genre]()
                    for genreDTO in genresListDTO.genres {
                        genres.append(Genre(genreDTO))
                    }
                    
                    DispatchQueue.main.async {
                        self.genres = genres
                        self.runGetUpcoming()
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.view.displayError(message: self.getMessage(from: error))
                    }
                }
            }
        }
    }
    
    func reloadAllMovies() {
        self.page = 1
        self.isReloadCall = true
        self.runGetUpcoming()
    }
    
    // MARK - Helpers
    func runGetUpcoming() {
        MoviesService.getUpcoming(page) {
            (upcomingMoviesDTO, error) in
            
            if let upcomingMoviesDTO = upcomingMoviesDTO {
                if (upcomingMoviesDTO.results.count < 1) {
                    if (self.page >= upcomingMoviesDTO.totalPages) {
                        DispatchQueue.main.async {
                            self.view.noMovies(message: "no upcoming movie found", last: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.noMovies(message: "no upcoming movie found", last: false)
                        }
                    }
                } else {
                    var movies = [Movie]()
                    for result in upcomingMoviesDTO.results {
                        let movie = Movie()
                        movie.name = result.title
                        movie.overview = result.overview
                        movie.releaseDate = result.releaseDate
                        if let poster = result.posterPath {
                            movie.posterImage = "\(Configurations.shared.tmdbImagesURL)\(Configurations.shared.imagesSize)\(poster)"
                        } else if let backdrop = result.backdropPath {
                            movie.posterImage = "\(Configurations.shared.tmdbImagesURL)\(Configurations.shared.imagesSize)\(backdrop)"
                        }
                        if let sGenres = self.parseGenreIdToName(result.genreIds) {
                            movie.genres = sGenres
                        } else {
                            DispatchQueue.main.async {
                                self.view.displayError(message: "error parsing genre names")
                            }
                            return
                        }
                        movies.append(movie)
                    }
                    
                    if (self.isReloadCall) {
                        DispatchQueue.main.async {
                            self.page += 1
                            self.movies = movies
                            self.isReloadCall = false
                            if (self.searchMode) {
                                self.view.reloadMovies(self.parseSearch(movies, self.searchString))
                            } else {
                                self.view.reloadMovies(movies)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.page += 1
                            
                            if (self.movies != nil) {
                                self.movies?.append(contentsOf: movies)
                                if (self.searchMode) {
                                    self.view.addMovies(self.parseSearch(movies, self.searchString), last: self.page >= upcomingMoviesDTO.totalPages ? true : false)
                                } else {
                                    self.view.addMovies(movies, last: self.page >= upcomingMoviesDTO.totalPages ? true : false)
                                }
                            } else {
                                self.movies = movies
                                if (self.searchMode) {
                                    self.view.setMovies(self.parseSearch(movies, self.searchString))
                                } else {
                                    self.view.setMovies(movies)
                                }
                            }
                        }
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view.displayError(message: self.getMessage(from: error))
                }
            }
            
            self.serviceRunning = false
        }
    }
    
    func getMessage(from error: Error) -> String {
        if let serviceError = error as? ServiceError {
            switch (serviceError) {
                case .urlSetup:
                    return "error setting up the url."
                case .noData:
                    return "data not found."
                case .jsonSerialization:
                    return "error on json serialization."
            }
        } else {
            return "error: \(error.localizedDescription)."
        }
    }
    
    func parseGenreIdToName(_ gIds: [Int]) -> [String]? {
        guard let genres = self.genres else {
            return nil
        }
        
        var sGenres = [String]()
        for gId in gIds {
            for genre in genres {
                if (gId == genre.id) {
                    sGenres.append(genre.name)
                }
            }
        }
        
        return sGenres
    }
    
    func parseSearch(_ movies: [Movie], _ string: String) -> [Movie] {
        return movies.filter({
            (movie) -> Bool in
            
            return movie.name.lowercased().range(of: string.lowercased()) != nil
        })
    }
    
    func filterBySearch(_ string: String) {
        if (string != "") {
            self.searchMode = true
            self.searchString = string
            
            guard let movies = self.movies else {
                return
            }
            
            self.view.setMovies(self.parseSearch(movies, string))
        } else {
            self.searchMode = false
            self.searchString = ""
            
            guard let movies = self.movies else {
                return
            }
            
            self.view.setMovies(movies)
        }
    }
}
