//
//  MoviesListView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class MoviesListView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tvMovies: UITableView!
    @IBOutlet weak var aivLoader: UIActivityIndicatorView!
    @IBOutlet weak var lMessage: UILabel!
    @IBOutlet weak var lMore: UILabel!
    @IBOutlet weak var sbName: UISearchBar!
    
    // MARK: - Constants
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Presenter
    var presenter: MoviesListPresenter?
    
    // MARK: - Variables
    var movies: [Movie]?
    var selectedMovie: Movie?
    var loadingMoreMovies: Bool = false
    var allPagesLoaded: Bool = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MoviesListPresenter(self)
        
        self.setupView()
    }
    
    // MARK: - Setups
    func setupView() {
        self.aivLoader.startAnimating()
        
        self.tvMovies.allowsSelection = true
        if #available(iOS 10.0, *) {
            self.tvMovies.refreshControl = self.refreshControl
        } else {
            self.tvMovies.insertSubview(refreshControl, at: 0)
        }
        self.refreshControl.tintColor = UIColor(red: 145 / 255, green: 142 / 255, blue: 244 / 255, alpha: 1.0)
        self.refreshControl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        
        self.presenter?.getUpcomingMovies()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ListToDetailSegue") {
            guard let detailView = segue.destination as? MovieDetailView else {
                return
            }
            
            detailView.movie = selectedMovie
            self.selectedMovie = nil
        }
    }
    
    // MARK: - Helpers
    func showAlertView(with title: String, and message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(alertAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @objc private func refreshTableView() {
        self.presenter?.reloadAllMovies()
    }
    
    func loadMoreMovies() {
        self.aivLoader.startAnimating()
        self.lMore.isHidden = false
        self.presenter?.getUpcomingMovies()
    }
    
    func displayAllPagesLoaded() {
        self.lMore.text = "no more upcoming movies to load"
        self.lMore.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.lMore.isHidden = true
            self.lMore.text = "loading more movies"
            self.loadingMoreMovies = false
        }
    }
}

// MARK: - Movie List Delegate
extension MoviesListView: MoviesListPresenterDelegate {
    func setMovies(_ movies: [Movie]) {
        self.lMessage.isHidden = true
        
        self.movies = movies
        
        self.tvMovies.reloadData()
        self.aivLoader.stopAnimating()
    }
    
    func noMovies(message: String, last: Bool) {
        self.allPagesLoaded = last
        
        guard let movies = self.movies else {
            self.lMessage.text = message
            self.tvMovies.isHidden = true
            
            self.aivLoader.stopAnimating()
            self.lMore.isHidden = true
            self.lMessage.isHidden = false
            return
        }
        
        if (movies.count < 1) {
            self.lMessage.text = message
            self.tvMovies.isHidden = true
            
            self.aivLoader.stopAnimating()
            self.lMore.isHidden = true
            self.lMessage.isHidden = false
        } else {
            self.aivLoader.stopAnimating()
            self.displayAllPagesLoaded()
        }
    }
    
    func reloadMovies(_ movies: [Movie]) {
        self.allPagesLoaded = false
        self.movies = movies
        self.tvMovies.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func displayError(message: String) {
        self.showAlertView(with: "ERROR", and: message)
    }
    
    func addMovies(_ movies: [Movie], last: Bool){
        self.allPagesLoaded = last
        
        guard (movies.count > 0) else {
            self.lMore.isHidden = true
            self.aivLoader.stopAnimating()
            self.loadingMoreMovies = false
            return
        }
        
        guard let _ = self.movies else {
            self.movies = movies
            self.loadingMoreMovies = false
            self.lMore.isHidden = true
            return
        }
        
        let startIndex = self.movies!.count
        let endIndex = startIndex + movies.count
        self.movies?.append(contentsOf: movies)
        
        var indexPaths = [IndexPath]()
        for i in startIndex..<endIndex {
            let indexPath = IndexPath(row: i, section: 0)
            indexPaths.append(indexPath)
        }
        
        self.tvMovies.insertRows(at: indexPaths, with: .fade)
        
        self.lMore.isHidden = true
        self.aivLoader.stopAnimating()
        self.loadingMoreMovies = false
    }
}

// MARK: - Table View Delegate
extension MoviesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movies = self.movies else {
            return
        }
        
        guard (movies.count > indexPath.row) else {
            return
        }
        
        self.selectedMovie = movies[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ListToDetailSegue", sender: self)
    }
}

// MARK: - Table View Data Source
extension MoviesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = self.movies else {
            return UITableViewCell()
        }
        
        guard (movies.count > indexPath.row) else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as? MovieItemCellView else {
            return UITableViewCell()
        }
        cell.setupCell(with: movies[indexPath.row])
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!self.loadingMoreMovies) {
            let height = scrollView.frame.size.height
            let bottomDistance = scrollView.contentSize.height - scrollView.contentOffset.y
            if (bottomDistance < height - 80) {
                self.loadingMoreMovies = true
                
                if (!self.allPagesLoaded) {
                    self.loadMoreMovies()
                } else {
                    self.displayAllPagesLoaded()
                }
            }
        }
    }
}

// MARK: - Search Bar Delegate
extension MoviesListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.aivLoader.startAnimating()
        
        if let search = searchBar.text {
            self.presenter?.filterBySearch(search)
        } else {
            self.presenter?.filterBySearch("")
        }
        
        self.sbName.resignFirstResponder()
    }
}
