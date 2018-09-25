//
//  Configurations.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class Configurations: NSObject {
    // MARK: - Singleton
    static let shared = Configurations()
    
    // MARK: - Constants
    let tmdbAPIURL: String = "https://api.themoviedb.org/3"
    let tmdbAPIKey: String = "1f54bd990f1cdfb230adb312546d765d"
    let tmdbImagesURL: String = "https://image.tmdb.org/t/p/"
    
    // MARK: - Variables
    var posterSize: String = "w342"
    var backdropSize: String = "w300"
    var language: String = "en-US"
    var itemsPerPage: Int = 20
    var region: String = ""
    
    // MARK: - Initializers
    private override init() {
        super.init()
        
        self.loadPosterSize()
        self.loadBackdropSize()
        self.loadLanguage()
        self.loadItemsPerPage()
        self.loadRegion()
    }
    
    // MARK: - Actions
    func savePosterSize(_ size: String = "w342") {
        if (size != self.posterSize) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(size, forKey: "posterSize")
            
            self.loadPosterSize()
        }
    }
    
    func saveBackdropSize(_ size: String = "w300") {
        if (size != self.backdropSize) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(size, forKey: "backdropSize")
            
            self.loadBackdropSize()
        }
    }
    
    func saveLanguage(_ iso: String = "en-US") {
        if (iso != self.language) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(iso, forKey: "language")
            
            self.loadLanguage()
        }
    }
    
    func saveItemsPerPage(_ value: Int = 20) {
        if (value != self.itemsPerPage) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(value, forKey: "itemsPerPage")
            
            self.loadItemsPerPage()
        }
    }
    
    func saveRegion(_ iso: String = "") {
        if (iso != self.region) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(iso, forKey: "region")
            
            self.loadRegion()
        }
    }
    
    // MARK: - Private Functions
    private func loadPosterSize() {
        let userDefaults = UserDefaults.standard
        if let size = userDefaults.object(forKey: "posterSize") as? String {
            self.posterSize = size
        } else {
            self.posterSize = "w342"
        }
    }
    
    private func loadBackdropSize() {
        let userDefaults = UserDefaults.standard
        if let size = userDefaults.object(forKey: "backdropSize") as? String {
            self.backdropSize = size
        } else {
            self.backdropSize = "w300"
        }
    }
    
    private func loadLanguage() {
        let userDefaults = UserDefaults.standard
        if let iso = userDefaults.object(forKey: "language") as? String {
            self.language = iso
        } else {
            self.language = "en-US"
        }
    }
    
    private func loadItemsPerPage() {
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.object(forKey: "itemsPerPage") as? Int {
            self.itemsPerPage = value
        } else {
            self.itemsPerPage = 20
        }
    }
    
    private func loadRegion() {
        let userDefaults = UserDefaults.standard
        if let iso = userDefaults.object(forKey: "region") as? String {
            self.region = iso
        } else {
            self.region = ""
        }
    }
}
