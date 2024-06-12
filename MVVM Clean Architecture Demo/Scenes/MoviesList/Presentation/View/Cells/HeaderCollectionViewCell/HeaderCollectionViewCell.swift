//
//  HeaderCollectionViewCell.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 12/06/2024.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieSectionTitleLabel: UILabel!
    @IBOutlet private weak var seeAllMoviesButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(sectionTitle: String) {
        movieSectionTitleLabel.text = sectionTitle
    }
}
