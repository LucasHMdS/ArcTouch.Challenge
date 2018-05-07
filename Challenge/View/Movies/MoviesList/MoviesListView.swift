//
//  MoviesListView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

// TODO List:
// - Load more when reach bottom
// - Search bar

class MoviesListView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tvMovies: UITableView!
    @IBOutlet weak var aivLoader: UIActivityIndicatorView!
    @IBOutlet weak var lMessage: UILabel!
    
    // MARK: - Constants
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Presenter
    var presenter: MoviesListPresenter?
    
    // MARK: - Variables
    var movies: [Movie]?
    var selectedMovie: Movie?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MoviesListPresenter(self)
        
        self.setupView()
    }
    
    // MARK: - Setups
    func setupView() {
        self.aivLoader.startAnimating()
        
        self.tvMovies.tableFooterView = UIView()
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
}

// MARK: - Movie List Delegate
extension MoviesListView: MoviesListPresenterDelegate {
    func addMovies(_ movies: [Movie]) {
        self.lMessage.isHidden = true
        
        if (self.movies == nil) {
            self.movies = movies
        } else {
            self.movies?.append(contentsOf: movies)
        }
        
        self.tvMovies.reloadData()
        self.aivLoader.stopAnimating()
        //TODO: Reload table view / update indexes
    }
    
    func noMovies(message: String) {
        self.lMessage.text = message
        
        self.aivLoader.stopAnimating()
        self.lMessage.isHidden = false
    }
    
    func reloadMovies(_ movies: [Movie]) {
        self.movies = movies
        self.tvMovies.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func displayError(message: String) {
        self.showAlertView(with: "Error", and: message)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell") as? MovieItemCellView else {
            return UITableViewCell()
        }
        cell.setupCell(with: movies[indexPath.row])
        
        return cell
    }
}
