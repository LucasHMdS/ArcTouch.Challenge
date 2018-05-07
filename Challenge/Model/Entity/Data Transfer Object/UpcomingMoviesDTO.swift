//
//  UpcomingMoviesDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class UpcomingMoviesDTO: NSObject {
    var page: Int = 0
    var results: [MovieDTO] = [MovieDTO]()
    var dates: DatesDTO = DatesDTO()
    var totalPages: Int = 0
    var totalResults: Int = 0
    
    // MARK: - Initializers
    init(_ json: NSDictionary) {
        super.init()
        
        if let iPage = json["page"] as? Int {
            self.page = iPage
        }
        
        if let aResults = json["results"] as? NSArray {
            for result in aResults {
                if let dResult = result as? NSDictionary {
                    let movieDTO = MovieDTO(dResult)
                    self.results.append(movieDTO)
                }
            }
        }
        
        if let oDates = json["dates"] as? NSDictionary {
            self.dates = DatesDTO(oDates)
        }
        
        if let iTotalPages = json["total_pages"] as? Int {
            self.totalPages = iTotalPages
        }
        
        if let iTotalResults = json["total_results"] as? Int {
            self.totalResults = iTotalResults
        }
    }
}
