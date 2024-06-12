//
//  MoviesListViewController.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 03/06/2024.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController {
    
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    private var viewModel: MoviesListViewModel!
    weak var coordinator: MoviesListCoordinator?
    private var cancellables = AppCancellable()
    private lazy var homeLayout = MoviesListLayout.shared
    private var autoScrollHandler: AutoScrollHandler?
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MoviesListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        autoScrollHandler?.startAutoScroll()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - viewWillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        autoScrollHandler?.stopAutoScroll()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setup() {
        setupMoviesCollectionView()
        setupBinding()
    }
    
    private func setupMoviesCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.collectionViewLayout = createCompositionalLayout()
        autoScrollHandler = AutoScrollHandler(collectionView: moviesCollectionView, section: 0, scrollInterval: 3.0)
        moviesCollectionView.registerNib(forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        moviesCollectionView.registerNib(forCellWithReuseIdentifier: "RegularMoviesCollectionViewCell")
        moviesCollectionView.registerSupplementaryView(forCellWithReuseIdentifier: "HeaderCollectionViewCell")
    }
    
    private func supplementaryHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Create UICollectionViewCompositionalLayout
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            
            guard let self, let sectionType = MoviesListSectionTypes(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
                
            case .nowPlayingMovies:
                return self.homeLayout.nowPlayingMoviesLayout()
                
            case .popularMovies:
                return self.homeLayout.generalHorizontalMoviesLayout(header: self.supplementaryHeaderView())
                
            case .topRatedMovies:
                return self.homeLayout.generalHorizontalMoviesLayout(header: self.supplementaryHeaderView())
                
            case .upcomingMovies:
                return self.homeLayout.generalHorizontalMoviesLayout(header: self.supplementaryHeaderView())
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        MoviesListSectionTypes.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionType = MoviesListSectionTypes(rawValue: section) else { return 0 }
        
        switch sectionType {
            
        case .nowPlayingMovies:
            return viewModel.moviesViewModel.nowPlayingMoviesCount()
            
        case .popularMovies:
            return viewModel.moviesViewModel.popularMoviesCount()
            
        case .upcomingMovies:
            return viewModel.moviesViewModel.upcomingMoviesCount()
            
        case .topRatedMovies:
            return viewModel.moviesViewModel.topRatedMoviesCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionType = MoviesListSectionTypes(rawValue: indexPath.section) else { fatalError("Invalid section") }
        
        switch sectionType {
            
        case .nowPlayingMovies:
            
            let movieCell: NowPlayingMoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let movies = viewModel.moviesViewModel.nowPlayingMovies?.results[indexPath.row] {
                var genres: [String] = []
                viewModel.genresViewModel.fetchGenreNames(from: movies.genreIds ?? []) { names in
                    genres = names
                }
                movieCell.config(with: NowPlayingCellViewModel(movie: movies), genres: genres)
            }
            return movieCell
            
        case .popularMovies:
            let movieCell: RegularMoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            guard let movie = viewModel.moviesViewModel.popularMovies?.results[indexPath.row] else {return UICollectionViewCell()}
            movieCell.config(with: RegularMoviesCellViewModel(movie: movie))
            return movieCell
            
        case .upcomingMovies:
            let movieCell: RegularMoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            guard let movie = viewModel.moviesViewModel.upcomingMovies?.results[indexPath.row] else {return UICollectionViewCell()}
            movieCell.config(with: RegularMoviesCellViewModel(movie: movie))
            return movieCell
            
        case .topRatedMovies:
            
            let movieCell: RegularMoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            guard let movie = viewModel.moviesViewModel.topRatedMovies?.results[indexPath.row] else {return UICollectionViewCell()}
            movieCell.config(with: RegularMoviesCellViewModel(movie: movie))
            return movieCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionType = MoviesListSectionTypes(rawValue: indexPath.section) else { fatalError("Invalid section") }
        
        switch sectionType {
            
        case .nowPlayingMovies:
            return UICollectionReusableView()
            
        case .topRatedMovies:
            let header: HeaderCollectionViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            header.config(sectionTitle: "Top Movies Picks")
            return header
            
        case .popularMovies:
            let header: HeaderCollectionViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            header.config(sectionTitle: "Popular Movies")
            return header
            
        case .upcomingMovies:
            let header: HeaderCollectionViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            header.config(sectionTitle: "Upcoming Movies")
            return header
        }
    }
    
}

// MARK: - Binding data

extension MoviesListViewController {
    
    private func setupBinding() {
        
        bindReloadViews()
        bindActivityIndocator()
        bindError()
    }
    
    private func bindReloadViews() {
        
        viewModel.moviesViewModel.$reloadView.sink { [weak self] status in
            guard let self, status else {return}
            self.moviesCollectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    private func bindActivityIndocator() {
        
        viewModel.moviesViewModel.$isLoading.sink { [weak self] isLoading in
            guard let self else {return}
            self.moviesCollectionView.isHidden = isLoading
            isLoading ? LoadingIndicatorManager.shared.startLoading(in: self.view) : LoadingIndicatorManager.shared.stopLoading()
        }.store(in: &cancellables)
    }
    
    private func bindError() {
        
        viewModel.moviesViewModel.$errorMessage.sink { [weak self] error in
            guard let self, let error else {return}
            Toast.show(type: .failure,
                       title: "Error",
                       message: error,
                       textColor: .white,
                       imageColor: .white,
                       controller: self)
            
        }.store(in: &cancellables)
        
        viewModel.genresViewModel.$errorMessage.sink { [weak self] error in
            guard let self, let error else {return}
            Toast.show(type: .failure,
                       title: "Error",
                       message: error,
                       textColor: .white,
                       imageColor: .white,
                       controller: self)
            
        }.store(in: &cancellables)
    }
}
