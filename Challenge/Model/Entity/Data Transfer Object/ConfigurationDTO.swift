//
//  ConfigurationDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

struct ConfigurationDTO: Codable {
    let images: ImagesDTO
    let changeKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}
