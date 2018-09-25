//
//  UpcomingMoviesDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

struct UpcomingMoviesDTO: Codable {
    let page: Int
    let results: [MovieDTO]
    let dates: DatesDTO
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
