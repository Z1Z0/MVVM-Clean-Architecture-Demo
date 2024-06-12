//
//  UICollectionView + Ext.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
    
    func registerNib(forCellWithReuseIdentifier reuseIdentifier: String) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func registerSupplementaryView(forCellWithReuseIdentifier reuseIdentifier: String) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String,
                                                                       for indexPath: IndexPath ) -> T {
        let identifier = String(describing: T.self)
        guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: identifier,
                                                          for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(identifier)")
        }
        return view
    }
}
