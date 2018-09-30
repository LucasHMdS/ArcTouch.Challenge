//
//  BaseService.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

enum ServiceError: Error {
    case urlSetup
    case noData
    case jsonSerialization
}

class BaseService: NSObject {
    static func getFullURL(_ category: String, _ endpoint: String, page: Int = 0, region: String = "") -> URL? {
        var urlString = "\(Configurations.shared.tmdbAPIURL)\(category)\(endpoint)?api_key=\(Configurations.shared.tmdbAPIKey)&language=\(Configurations.shared.language)"
        if (page != 0) {
            urlString.append("&page=\(page)")
        }
        if (region != "") {
            urlString.append("&region=\(region)")
        }
        
        if let url = URL(string: urlString) {
            return url
        } else {
            return nil
        }
    }
}
