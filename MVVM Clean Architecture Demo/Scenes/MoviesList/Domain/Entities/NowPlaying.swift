//
//  NowPlaying.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int?
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let genreIds: [Int]?
    let voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
    }
}
