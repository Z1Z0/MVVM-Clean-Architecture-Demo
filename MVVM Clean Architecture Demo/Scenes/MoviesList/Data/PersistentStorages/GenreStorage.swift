//
//  GenreStorage.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import Foundation
import Combine

protocol GenreStorageProtocol: AnyObject {
    
    func loadGenre() -> AnyPublisher<[Genre], Error>
    func fetchGenreNames(from ids: [Int], genres: [Genre]) -> AnyPublisher<[String], Never>
}

class GenreStorage: GenreStorageProtocol {
    
    func loadGenre() -> AnyPublisher<[Genre], Error> {
        
        guard let url = Bundle.main.url(forResource: "Genre", withExtension: "json") else {
            return Fail(error: NSError(domain: "Genres file not found", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        return Future<[Genre], Error> { promise in
            do {
                let data = try Data(contentsOf: url)
                let genreList = try JSONDecoder().decode(GenreList.self, from: data)
                promise(.success(genreList.genres))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
        
    }
    
    func fetchGenreNames(from ids: [Int], genres: [Genre]) -> AnyPublisher<[String], Never> {
        
        let names = ids.compactMap { id in
            genres.first { $0.id == id }?.name
        }
        return Just(names).eraseToAnyPublisher()
    }
}
