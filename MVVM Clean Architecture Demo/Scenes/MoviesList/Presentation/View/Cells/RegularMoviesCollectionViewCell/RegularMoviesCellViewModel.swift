//
//  RegularMoviesCellViewModel.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import Foundation

struct RegularMoviesCellViewModel {
    var id: Int
    var title: String
    var rating: Float
    var image: String
    
    init(movie: Movie) {
        self.id = movie.id ?? 0
        self.title = movie.title ?? ""
        self.image = movie.posterPath ?? ""
        self.rating = movie.voteAverage ?? 0.0
    }
}
