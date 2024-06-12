//
//  RegularMoviesCollectionViewCell.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import UIKit
import Kingfisher

class RegularMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingContainerView: GlassEffectView!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        
        containerView.clipsToBounds = true
        containerView.roundCorners(.allCorners, radius: 12)
        ratingContainerView.roundCorners([.allCorners], radius: 6)
        ratingContainerView.addBorder(width: 1)
        
    }
    
    func config(with movie: RegularMoviesCellViewModel) {
        
        ratingLabel.text = String(format: "%.1f", movie.rating)
        movieTitleLabel.text = movie.title
        
        let processor = DownsamplingImageProcessor(size: movieImage.bounds.size)
        let movieImageURL = URL(string: NetworkConfiguration.shared.moviesImageBasePath + movie.image)
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: movieImageURL, options: [.processor(processor),
                                                              .scaleFactor(UIScreen.main.scale),
                                                              .transition(.fade(1)),
                                                              .cacheOriginalImage])
    }
    
}
