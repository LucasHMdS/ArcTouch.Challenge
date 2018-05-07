//
//  MoviesService.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class MoviesService: BaseService {
    // MARK: - Constans
    private static let endpoint = "/movie"
    
    // MARK: - Services
    static func getUpcoming(_ page: Int = 0, completionHandler: @escaping (UpcomingMoviesDTO?, Error?) -> Void) {
        guard let url = getFullURL(endpoint, "/upcoming", page: page, region: Configurations.shared.region) else {
            completionHandler(nil, ServiceError.urlSetup)
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, ServiceError.noData)
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary else {
                completionHandler(nil, ServiceError.jsonSerialization)
                return
            }
            
            completionHandler(UpcomingMoviesDTO(json), nil)
        }.resume()
    }
}
