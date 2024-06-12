//
//  GenreUseCase.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 11/06/2024.
//

import Foundation
import Combine

protocol GenreUseCaseProtocol: AnyObject {
    func loadGenre(completion: @escaping (Result<[Genre], Error>) -> Void)
    func fetchGenreNames(from ids: [Int], genres: [Genre], completion: @escaping (Result<[String], Error>) -> Void)
}

class GenreUseCase: GenreUseCaseProtocol {
    
    private let repository: GenreRepositoryProtocol
    private var cancellable = AppCancellable()
    
    init(repository: GenreRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadGenre(completion: @escaping (Result<[Genre], Error>) -> Void) {
        
        repository.loadGenre().sink(receiveCompletion: { status in
            
            switch status {
            case .finished:
                break
            case .failure(let error):
                completion(.failure(error))
            }
            
        }, receiveValue: { genres in
            completion(.success(genres))
        }).store(in: &cancellable)

    }
    
    func fetchGenreNames(from ids: [Int], genres: [Genre], completion: @escaping (Result<[String], Error>) -> Void) {
        
        repository.fetchGenreNames(from: ids, genres: genres).sink(receiveCompletion: { status in
            switch status {
            case .finished:
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }, receiveValue: { genresNames in
            completion(.success(genresNames))
        }).store(in: &cancellable)
    }
    
}
