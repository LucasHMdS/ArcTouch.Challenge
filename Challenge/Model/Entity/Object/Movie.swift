//
//  Movie.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import Foundation

class Movie {
    var name: String
    var posterImage: String
    var genres: [String]
    var releaseDate: String
    var overview: String
    
    // MARK: - Initializers
    init() {
        self.name = ""
        self.posterImage = ""
        self.genres = [String]()
        self.releaseDate = ""
        self.overview = ""
    }
    
    // MARK: - Functions
    func getGenresText() -> String {
        var genresText = ""
        
        var count = 0
        for genre in self.genres {
            if (count == 0) {
                genresText.append(genre)
            } else if (count == self.genres.count - 1) {
                genresText.append(" and \(genre)")
            } else {
                genres.append(", \(genre)")
            }
            count += 1
        }
        
        return genresText
    }
}
