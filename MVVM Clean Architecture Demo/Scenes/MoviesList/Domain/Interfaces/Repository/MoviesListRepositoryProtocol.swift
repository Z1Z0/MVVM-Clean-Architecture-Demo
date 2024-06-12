//
//  MoviesListRepositoryProtocol.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

protocol MoviesListRepositoryProtocol: AnyObject {
    func fetchNowPlayingMovies() -> PublisherResponse<Movies>
    func fetchTopRatedMovies() -> PublisherResponse<Movies>
    func fetchUpcomingMovies() -> PublisherResponse<Movies>
    func fetchPopularMovies() -> PublisherResponse<Movies>
}
