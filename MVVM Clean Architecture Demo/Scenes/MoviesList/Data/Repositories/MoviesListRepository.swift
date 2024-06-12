//
//  MoviesListRepository.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

class MoviesListRepository: MoviesListRepositoryProtocol {
    
    private let remoteDS: MoviesListRemoteDataSourceProtocol
    
    init(remoteDS: MoviesListRemoteDataSourceProtocol = MoviesListRemoteDataSource()) {
        self.remoteDS = remoteDS
    }
    
    func fetchNowPlayingMovies() -> PublisherResponse<Movies> {
        return remoteDS.fetchNowPlayingMovies()
    }
    
    func fetchTopRatedMovies() -> PublisherResponse<Movies> {
        return remoteDS.fetchTopRatedMovies()
    }
    
    func fetchUpcomingMovies() -> PublisherResponse<Movies> {
        return remoteDS.fetchUpcomingMovies()
    }
    
    func fetchPopularMovies() -> PublisherResponse<Movies> {
        return remoteDS.fetchPopularMovies()
    }
    
}
