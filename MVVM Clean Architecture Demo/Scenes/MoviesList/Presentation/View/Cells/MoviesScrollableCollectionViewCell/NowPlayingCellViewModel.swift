//
//  MoviesScrollableCollectionViewCellModel.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 06/06/2024.
//

import Foundation

struct NowPlayingCellViewModel {
    var id: Int
    var title: String
    var rating: Float
    var image: String
    var genre: [Int]
    
    init(movie: Movie) {
        self.id = movie.id ?? 0
        self.title = movie.title ?? ""
        self.image = movie.backdropPath ?? ""
        self.genre = movie.genreIds ?? [0]
        self.rating = movie.voteAverage ?? 0.0
    }
}
