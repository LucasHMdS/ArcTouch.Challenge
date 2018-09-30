//
//  GenresService.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class GenresService: BaseService {
    // MARK: - Constants
    private static let endpoint = "/genre"
    
    // MARK: - Services
    static func getMovieList(completionHandler: @escaping (GenresListDTO?, Error?) -> Void) {
        guard let url = getFullURL(endpoint, "/movie/list") else {
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
            
            do {
                let genresListDTO = try JSONDecoder().decode(GenresListDTO.self, from: data)
                completionHandler(genresListDTO, nil)
            } catch {
                completionHandler(nil, ServiceError.jsonSerialization)
                return
            }
        }.resume()
    }
}
