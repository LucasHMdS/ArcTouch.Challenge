//
//  ConfigurationDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class ConfigurationDTO: NSObject {
    var images: ImagesDTO = ImagesDTO()
    var changeKeys: [String] = [String]()
    
    // MARK: - Initializers
    init(_ json: NSDictionary) {
        super.init()
        
        if let oImages = json["images"] as? NSDictionary {
            self.images = ImagesDTO(oImages)
        }
        
        if let aChangeKeys = json["change_keys"] as? NSArray {
            for key in aChangeKeys {
                if let sKey = key as? String {
                    self.changeKeys.append(sKey)
                }
            }
        }
    }
}
