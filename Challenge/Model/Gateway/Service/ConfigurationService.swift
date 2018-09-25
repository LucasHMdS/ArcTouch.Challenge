//
//  ConfigurationService.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class ConfigurationService: BaseService {
    // MARK: - Constants
    private static let endpoint = "/configuration"
    
    // MARK: - Service
    static func getConfiguration(completionHandler: @escaping (ConfigurationDTO?, Error?) -> Void) {
        guard let url = getFullURL(endpoint, "") else {
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
                let configurationDTO = try JSONDecoder().decode(ConfigurationDTO.self, from: data)
                completionHandler(configurationDTO, nil)
            } catch {
                completionHandler(nil, ServiceError.jsonSerialization)
                return
            }
        }.resume()
    }
}
