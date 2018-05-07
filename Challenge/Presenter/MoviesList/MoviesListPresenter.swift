//
//  MoviesListPresenter.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import Foundation

protocol MoviesListPresenterDelegate {
    func addMovies(_ movies: [Movie])
    func noMovies(message: String)
    func reloadMovies(_ movies: [Movie])
    func displayError(message: String)
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
                    DispatchQueue.main.async {
                        self.view.noMovies(message: "No upcoming movie found")
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
                                self.view.displayError(message: "Error parsing genre names")
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
                            self.view.reloadMovies(movies)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.page += 1
                            
                            if (self.movies != nil) {
                                self.movies?.append(contentsOf: movies)
                            } else {
                                self.movies = movies
                            }
                            
                            self.view.addMovies(movies)
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
                    return "Error setting up the url."
                case .noData:
                    return "Data not found."
                case .jsonSerialization:
                    return "Error on json serialization."
            }
        } else {
            return "Error: \(error.localizedDescription)."
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
}
