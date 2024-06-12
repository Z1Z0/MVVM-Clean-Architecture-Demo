//
//  AutoScrollHandler.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 12/06/2024.
//

import UIKit

class AutoScrollHandler: NSObject {
    private weak var collectionView: UICollectionView?
    private var autoScrollTimer: Timer?
    private var scrollInterval: TimeInterval
    private var sectionToAutoScroll: Int
    
    init(collectionView: UICollectionView, section: Int, scrollInterval: TimeInterval = 3.0) {
        self.collectionView = collectionView
        self.scrollInterval = scrollInterval
        self.sectionToAutoScroll = section
        super.init()
        startAutoScroll()
    }
    
    deinit {
        stopAutoScroll()
    }
    
    func startAutoScroll() {
        stopAutoScroll()
        autoScrollTimer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(autoScrollCollectionView), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc private func autoScrollCollectionView() {
        guard let indexPath = getCurrentVisibleIndexPath(for: sectionToAutoScroll) else { return }
        let nextIndexPath = getNextIndexPath(for: indexPath)
        collectionView?.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func getCurrentVisibleIndexPath(for section: Int) -> IndexPath? {
        guard let collectionView = collectionView else { return nil }
        let visibleItems = collectionView.indexPathsForVisibleItems.filter { $0.section == section }
        guard !visibleItems.isEmpty else { return nil }
        return visibleItems.first
    }
    
    private func getNextIndexPath(for currentIndexPath: IndexPath) -> IndexPath {
        guard let collectionView = collectionView else { return currentIndexPath }
        let itemCount = collectionView.numberOfItems(inSection: currentIndexPath.section)
        let nextItem = (currentIndexPath.item + 1) % itemCount
        return IndexPath(item: nextItem, section: currentIndexPath.section)
    }
}
