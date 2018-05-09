//
//  DatesDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class DatesDTO: NSObject {
    var maximum: String = ""
    var minimum: String = ""
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    init(_ json: NSDictionary) {
        super.init()
        
        if let sMaximum = json["maximum"] as? String {
            self.maximum = sMaximum
        }
        
        if let sMinimum = json["minimum"] as? String {
            self.minimum = sMinimum
        }
    }
}
