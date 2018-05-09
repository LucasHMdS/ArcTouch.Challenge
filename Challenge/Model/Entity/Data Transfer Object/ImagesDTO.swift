//
//  ImagesDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class ImagesDTO: NSObject {
    var baseUrl: String = ""
    var secureBaseUrl: String = ""
    var backdropSizes: [String] = [String]()
    var logoSizes: [String] = [String]()
    var posterSizes: [String] = [String]()
    var profileSizes: [String] = [String]()
    var stillSizes: [String] = [String]()
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    init(_ json: NSDictionary) {
        super.init()
        
        if let sBaseUrl = json["base_url"] as? String {
            self.baseUrl = sBaseUrl
        }
        
        if let sSecureBaseUrl = json["secure_base_url"] as? String {
            self.secureBaseUrl = sSecureBaseUrl
        }
        
        if let aBackdropSizes = json["backdrop_sizes"] as? NSArray {
            for size in aBackdropSizes {
                if let sSize = size as? String {
                    self.backdropSizes.append(sSize)
                }
            }
        }
        
        if let aLogoSizes = json["logo_sizes"] as? NSArray {
            for size in aLogoSizes {
                if let sSize = size as? String {
                    self.logoSizes.append(sSize)
                }
            }
        }
        
        if let aPosterSizes = json["poster_sizes"] as? NSArray {
            for size in aPosterSizes {
                if let sSize = size as? String {
                    self.posterSizes.append(sSize)
                }
            }
        }
        
        if let aProfileSizes = json["profile_sizes"] as? NSArray {
            for size in aProfileSizes {
                if let sSize = size as? String {
                    self.profileSizes.append(sSize)
                }
            }
        }
        
        if let aStillSizes = json["still_sizes"] as? NSArray {
            for size in aStillSizes {
                if let sSize = size as? String {
                    self.stillSizes.append(sSize)
                }
            }
        }
    }
}
