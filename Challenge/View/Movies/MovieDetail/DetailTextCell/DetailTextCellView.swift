//
//  DetailTextCellView.swift
//  Challenge
//
//  Created by Lucas Henrique Machado da Silva on 06/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import UIKit

class DetailTextCellView: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lText: UILabel!
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setups
    func setupCell(with text: String, and font: UIFont) {
        self.lText.font = font
        self.lText.text = text
    }
}
