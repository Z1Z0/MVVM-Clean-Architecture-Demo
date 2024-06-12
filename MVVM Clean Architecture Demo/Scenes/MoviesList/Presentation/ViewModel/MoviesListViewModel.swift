//
//  MoviesListViewModel.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

class MoviesListViewModel {
    
    @Published var moviesViewModel: MoviesViewModel
    @Published var genresViewModel: GenresViewModel
    
    init(moviesUseCase: MoviesListUseCaseProtocol, genresUseCase: GenreUseCaseProtocol) {
        self.moviesViewModel = MoviesViewModel(moviesUseCase: moviesUseCase)
        self.genresViewModel = GenresViewModel(genresUseCase: genresUseCase)
    }
    
}
