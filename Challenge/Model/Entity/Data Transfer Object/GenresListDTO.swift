//
//  GenresListDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class GenresListDTO: NSObject {
    var genres: [GenreDTO] = [GenreDTO]()
    
    init(_ json: NSDictionary) {
        super.init()
        
        if let aGenres = json["genres"] as? NSArray {
            for genre in aGenres {
                if let dGenre = genre as? NSDictionary {
                    let genreDTO = GenreDTO(dGenre)
                    self.genres.append(genreDTO)
                }
            }
        }
    }
}
