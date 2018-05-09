//
//  Genre.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class Genre {
    var id: Int
    var name: String
    
    // MARK: - Initializers
    init(id: Int = 0, name: String = "") {
        self.id = id
        self.name = name
    }
    
    init(_ genreDTO: GenreDTO) {
        self.id = genreDTO.gId
        self.name = genreDTO.name
    }
}
