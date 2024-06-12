//
//  MoviesScrollableCollectionViewCell.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 04/06/2024.
//

import UIKit
import Kingfisher

class NowPlayingMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingContainerView: GlassEffectView!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titleAndGenreContainerView: GlassEffectView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieGenreLabel: UILabel!
    @IBOutlet private weak var addToWishlistButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        titleAndGenreContainerView.addBorder(to: [.top], color: .white, thickness: 0.6)
    }
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        containerView.roundCorners(.allCorners, radius: 12)
        ratingContainerView.roundCorners([.allCorners], radius: 6)
        ratingContainerView.addBorder(width: 1)
        addToWishlistButton.roundCorners(.allCorners, radius: 5)
        
    }

    func config(with movie: NowPlayingCellViewModel, genres: [String]) {
        ratingLabel.text = String(format: "%.1f", movie.rating)
        movieTitleLabel.text = movie.title
        movieGenreLabel.text = genres.joined(separator: "  ")
        
        let processor = DownsamplingImageProcessor(size: movieImage.bounds.size)
        let movieImageURL = URL(string: NetworkConfiguration.shared.moviesImageBasePath + movie.image)
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: movieImageURL, options: [.processor(processor),
                                                              .scaleFactor(UIScreen.main.scale),
                                                              .transition(.fade(1)),
                                                              .cacheOriginalImage])
    }

}
