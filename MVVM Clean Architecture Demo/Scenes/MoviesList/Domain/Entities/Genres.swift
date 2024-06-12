//
//  Genres.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 10/06/2024.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreList: Codable {
    let genres: [Genre]
}
