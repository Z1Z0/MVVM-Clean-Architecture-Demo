//
//  GenreRepository.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import Foundation
import Combine

class GenreRepository: GenreRepositoryProtocol {
    
    private let storageDS: GenreStorageProtocol
    
    init(storageDS: GenreStorageProtocol = GenreStorage()) {
        self.storageDS = storageDS
    }
    
    func loadGenre() -> AnyPublisher<[Genre], Error> {
        return storageDS.loadGenre()
    }
    
    func fetchGenreNames(from moviesIds: [Int], genres: [Genre]) -> AnyPublisher<[String], Never> {
        return storageDS.fetchGenreNames(from: moviesIds, genres: genres)
    }
    
}
