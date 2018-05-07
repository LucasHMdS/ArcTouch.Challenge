//
//  MovieDetailView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class MovieDetailView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tvDetail: UITableView!
    
    // MARK: - Presenter
    var presenter: MovieDetailPresenter?
    
    // MARK: - Variables
    var movie: Movie?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie Details"
        self.presenter = MovieDetailPresenter(self, self.movie)
    }
    
    // MARK: - Setup
    func setupView() {
        self.tvDetail.rowHeight = UITableViewAutomaticDimension
        self.tvDetail.estimatedRowHeight = 150
    }
}

// MARK: - Table View Delegate
extension MovieDetailView: MovieDetailPresenterDelegate {
}

// MARK: - Table View Delegate
extension MovieDetailView: UITableViewDelegate {
}

// MARK: - Table View Data Source
extension MovieDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = self.movie else {
            return UITableViewCell()
        }
        
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as? DetailImageCellView else {
                return UITableViewCell()
            }
            
            cell.setupCell(with: movie.posterImage)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTextCell") as? DetailTextCellView else {
                return UITableViewCell()
            }
            
            switch (indexPath.row) {
                case 1:
                    cell.setupCell(with: movie.name, and: UIFont.boldSystemFont(ofSize: 19.0))
                    break
                
                case 2:
                    cell.setupCell(with: movie.overview, and: UIFont.systemFont(ofSize: 16.0))
                    break
                
                case 3:
                    cell.setupCell(with: movie.getGenresText(), and: UIFont.italicSystemFont(ofSize: 14.0))
                    break
                
                case 4:
                    cell.setupCell(with: movie.releaseDate, and: UIFont.italicSystemFont(ofSize: 14.0))
                    break
                
                default:
                    break
            }
            
            return cell
        }
    }
}
