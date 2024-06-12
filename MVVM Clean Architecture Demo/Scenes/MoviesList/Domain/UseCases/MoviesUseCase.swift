//
//  MoviesUseCase.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

protocol MoviesListUseCaseProtocol: AnyObject {
    func fetchNowPlayingMovies(completion: @escaping ((ResultResponse<Movies>) -> Void))
    func fetchTopRatedMovies(completion: @escaping ((ResultResponse<Movies>) -> Void))
    func fetchUpcomingMovies(completion: @escaping ((ResultResponse<Movies>) -> Void))
    func fetchPopularMovies(completion: @escaping ((ResultResponse<Movies>) -> Void))
}

class MoviesListUseCase: MoviesListUseCaseProtocol {
    
    private let repository: MoviesListRepositoryProtocol
    private var cancellable = AppCancellable()
    
    init(repository: MoviesListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchNowPlayingMovies(completion: @escaping ResultResponseCompletion<Movies>) {
        repository.fetchNowPlayingMovies().singleOutput(with: &cancellable) { completion($0) }
    }
    
    func fetchTopRatedMovies(completion: @escaping ((ResultResponse<Movies>) -> Void)) {
        repository.fetchTopRatedMovies().singleOutput(with: &cancellable) { completion($0) }
    }
    
    func fetchUpcomingMovies(completion: @escaping ((ResultResponse<Movies>) -> Void)) {
        repository.fetchUpcomingMovies().singleOutput(with: &cancellable) { completion($0) }
    }
    
    func fetchPopularMovies(completion: @escaping ((ResultResponse<Movies>) -> Void)) {
        repository.fetchPopularMovies().singleOutput(with: &cancellable) { completion($0) }
    }
}
