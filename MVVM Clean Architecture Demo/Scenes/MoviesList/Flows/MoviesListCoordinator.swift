//
//  MoviesListCoordinator.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation

enum MoviesListNavigationDestination: NavigationDestination {
    case moviesDetails(id: Int)
}

class MoviesListCoordinator: BaseCoordinator<Void> {
    
    override func start() {
        
        let moviesUseCase = MoviesListUseCase(repository: MoviesListRepository())
        let genresUseCase = GenreUseCase(repository: GenreRepository())
        
        let viewModel = MoviesListViewModel(moviesUseCase: moviesUseCase, genresUseCase: genresUseCase)
        let viewController = MoviesListViewController(viewModel: viewModel)
        
        viewController.coordinator = self
        router.push(viewController, animated: false)
    }
}
