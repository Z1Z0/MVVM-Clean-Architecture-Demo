//
//  MoviesListLayout.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 10/06/2024.
//

import UIKit

final class MoviesListLayout {
    
    static let shared = MoviesListLayout()
    
    private init() {}
    
    func nowPlayingMoviesLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(222)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    func generalHorizontalMoviesLayout(header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(335)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.supplementaryContentInsetsReference = .safeArea
        return section
    }
}
