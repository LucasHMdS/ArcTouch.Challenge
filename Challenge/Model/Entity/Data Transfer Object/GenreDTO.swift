//
//  GenreDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class GenreDTO: NSObject {
    var gId: Int = 0
    var name: String = ""
    
    
    init(_ json: NSDictionary) {
        super.init()
        
        if let iId = json["id"] as? Int {
            self.gId = iId
        }
        
        if let sName = json["name"] as? String {
            self.name = sName
        }
    }
}
