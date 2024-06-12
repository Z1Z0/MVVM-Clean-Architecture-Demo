//
//  MoviesListRemoteDataSource.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

protocol MoviesListRemoteDataSourceProtocol: AnyObject {
    func fetchNowPlayingMovies() -> PublisherResponse<Movies>
    func fetchTopRatedMovies() -> PublisherResponse<Movies>
    func fetchUpcomingMovies() -> PublisherResponse<Movies>
    func fetchPopularMovies() -> PublisherResponse<Movies>
}

class MoviesListRemoteDataSource: BaseAPI<MoviesListNetworking>, MoviesListRemoteDataSourceProtocol {
    
    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    
    func fetchNowPlayingMovies() -> PublisherResponse<Movies> {
        return fetchData(target: .nowPlaying, responseClass: Movies.self, bearerToken: apiKey)
    }
    
    func fetchTopRatedMovies() -> PublisherResponse<Movies> {
        return fetchData(target: .topRated, responseClass: Movies.self, bearerToken: apiKey)
    }
    
    func fetchUpcomingMovies() -> PublisherResponse<Movies> {
        return fetchData(target: .upcoming, responseClass: Movies.self, bearerToken: apiKey)
    }
    
    func fetchPopularMovies() -> PublisherResponse<Movies> {
        return fetchData(target: .popular, responseClass: Movies.self, bearerToken: apiKey)
    }
}
