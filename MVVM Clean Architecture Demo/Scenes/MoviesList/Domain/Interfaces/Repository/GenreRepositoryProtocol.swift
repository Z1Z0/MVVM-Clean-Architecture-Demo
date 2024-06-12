//
//  GenreRepositoryProtocol.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import Foundation
import Combine

protocol GenreRepositoryProtocol: AnyObject {
    
    func loadGenre() -> AnyPublisher<[Genre], Error>
    func fetchGenreNames(from ids: [Int], genres: [Genre]) -> AnyPublisher<[String], Never>
    
}
