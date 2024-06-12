//
//  MoviesViewModel.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 12/06/2024.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    
    @Published private(set) var nowPlayingMovies: Movies?
    @Published private(set) var topRatedMovies: Movies?
    @Published private(set) var upcomingMovies: Movies?
    @Published private(set) var popularMovies: Movies?
    
    @Published var errorMessage: String?
    @Published var reloadView: Bool = false
    @Published var isLoading: Bool = false
    
    private let moviesUseCase: MoviesListUseCaseProtocol
    private var cancellables = AppCancellable()
    
    init(moviesUseCase: MoviesListUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        fetchNowPlayingMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
        fetchPopularMovies()
    }
    
    // MARK: - fetchNowPlayingMovies
    
    private func fetchNowPlayingMovies() {
        
        isLoading = true
        
        moviesUseCase.fetchNowPlayingMovies { [weak self] result in
            
            guard let self else {return}
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.nowPlayingMovies = response
                self.reloadView = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func nowPlayingMoviesCount() -> Int {
        nowPlayingMovies?.results.count ?? 0
    }
    
    // MARK: - fetchTopRatedMovies
    
    private func fetchTopRatedMovies () {
        
        isLoading = true
        
        moviesUseCase.fetchTopRatedMovies { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success(let response):
                self.topRatedMovies = response
                self.reloadView = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func topRatedMoviesCount() -> Int {
        topRatedMovies?.results.count ?? 0
    }
    
    private func fetchUpcomingMovies () {
        
        isLoading = true
        
        moviesUseCase.fetchUpcomingMovies { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success(let response):
                self.upcomingMovies = response
                self.reloadView = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func upcomingMoviesCount() -> Int {
        upcomingMovies?.results.count ?? 0
    }
    
    private func fetchPopularMovies () {
        
        isLoading = true
        
        moviesUseCase.fetchPopularMovies { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success(let response):
                self.popularMovies = response
                self.reloadView = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func popularMoviesCount() -> Int {
        popularMovies?.results.count ?? 0
    }
}
