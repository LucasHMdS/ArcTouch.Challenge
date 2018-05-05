//
//  MovieDTO.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 05/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class MovieDTO: NSObject {
    var posterPath: String? = nil
    var adult: Bool = false
    var overview: String = ""
    var releaseDate: String = ""
    var genreIds: [Int] = [Int]()
    var mId: Int = 0
    var originalTitle: String = ""
    var originalLanguage: String = ""
    var title: String = ""
    var backdropPath: String? = nil
    var popularity: Double = 0.00
    var voteCount: Int = 0
    var video: Bool = false
    var voteAverage: Double = 0.00
    
    init(_ json: NSDictionary) {
        super.init()
        
        if let sPosterPath = json["poster_path"] as? String {
            self.posterPath = sPosterPath
        }
        
        if let bAdult = json["adult"] as? Bool {
            self.adult = bAdult
        }
        
        if let sOverview = json["overview"] as? String {
            self.overview = sOverview
        }
        
        if let sReleaseDate = json["release_date"] as? String {
            self.releaseDate = sReleaseDate
        }
        
        if let aGenreIds = json["genre_ids"] as? NSArray {
            for genreId in aGenreIds {
                if let iGenreId = genreId as? Int {
                    self.genreIds.append(iGenreId)
                }
            }
        }
        
        if let iId = json["id"] as? Int {
            self.mId = iId
        }
        
        if let sOriginalTitle = json["original_title"] as? String {
            self.originalTitle = sOriginalTitle
        }
        
        if let sOriginalLanguage = json["original_language"] as? String {
            self.originalLanguage = sOriginalLanguage
        }
        
        if let sTitle = json["title"] as? String {
            self.title = sTitle
        }
        
        if let sBackdropPath = json["backdrop_path"] as? String {
            self.backdropPath = sBackdropPath
        }
        
        if let dPopularity = json["popularity"] as? Double {
            self.popularity = dPopularity
        }
        
        if let iVoteCount = json["vote_count"] as? Int {
            self.voteCount = iVoteCount
        }
        
        if let bVideo = json["video"] as? Bool {
            self.video = bVideo
        }
        
        if let dVoteAverage = json["vote_average"] as? Double {
            self.voteAverage = dVoteAverage
        }
    }
}
