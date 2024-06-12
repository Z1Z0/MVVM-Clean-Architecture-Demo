//
//  NetworkConfiguration.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 03/06/2024.
//

import Foundation

struct NetworkConfiguration {
    
    static let shared = NetworkConfiguration()
    
    let baseURL: String
    let moviesBasePath: String
    let moviesImageBasePath: String
    let genre: String
    
    private init() {
        self.baseURL = "https://api.themoviedb.org/3"
        self.moviesBasePath = "/movie"
        self.moviesImageBasePath = "https://image.tmdb.org/t/p/w500"
        self.genre = "/genre"
    }
    
}
