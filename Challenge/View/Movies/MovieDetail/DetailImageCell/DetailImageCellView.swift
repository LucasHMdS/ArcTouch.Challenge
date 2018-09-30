//
//  DetailImageCellView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class DetailImageCellView: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var ivPoster: UIImageView!
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setups
    func setupCell(with imageURL: String) {
        if (imageURL.contains("jpg")) {
            if let imageURL = URL(string: imageURL) {
                self.ivPoster.kf.setImage(with: imageURL)
            } else {
                self.ivPoster.image = UIImage(named: "Placeholder")
            }
        } else {
            self.ivPoster.image = UIImage(named: "Placeholder")
        }
    }
}
