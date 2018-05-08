//
//  MovieItemCellView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit
import Kingfisher

class MovieItemCellView: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lGenres: UILabel!
    @IBOutlet weak var lDate: UILabel!
    
    // MARK: - Variables
    var movie: Movie?
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setups
    func setupCell(with movie: Movie) {
        self.movie = movie
        
        if (movie.posterImage.contains("jpg")) {
            if let imageURL = URL(string: movie.posterImage) {
                self.ivPoster.kf.setImage(with: imageURL)
            } else {
                self.ivPoster.image = UIImage(named: "Placeholder")
            }
        } else {
            self.ivPoster.image = UIImage(named: "Placeholder")
        }
        
        self.lName.text = movie.name
        self.lGenres.text = movie.getGenresText()
        self.lDate.text = movie.releaseDate
    }
}
