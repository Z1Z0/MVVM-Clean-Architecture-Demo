//
//  GenresViewModel.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 12/06/2024.
//

import Foundation
import Combine

class GenresViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    private var genres: [Genre] = []
    
    private let genresUseCase: GenreUseCaseProtocol
    
    init(genresUseCase: GenreUseCaseProtocol) {
        self.genresUseCase = genresUseCase
        loadGenres()
    }
    
    private func loadGenres() {
        
        genresUseCase.loadGenre { [weak self] result in
            
            guard let self else {return}
            
            switch result {
                
            case .success(let genres):
                self.genres = genres
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func genreNames(from ids: [Int]) -> [String] {
        var names = [String]()
        for id in ids {
            if let genre = genres.first(where: { $0.id == id }) {
                names.append(genre.name)
            }
        }
        return names
    }
    
    func fetchGenreNames(from ids: [Int], completion: @escaping ([String]) -> Void) {
        
        genresUseCase.fetchGenreNames(from: ids, genres: genres) { result in
            
            switch result {
            case .success(let names):
                completion(names)
            case .failure(_):
                break
            }
        }
    }
}
