//
//  MovieDetailPresenter.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterDelegate {
}

class MovieDetailPresenter: NSObject {
    // MARK: - View 'Reference'
    var view: MovieDetailPresenterDelegate
    
    // MARK: - Variables
    var movie: Movie?
    
    // MARK: - Initializers
    init(_ delegate: MovieDetailPresenterDelegate, _ movie: Movie?) {
        self.view = delegate
    }
}
