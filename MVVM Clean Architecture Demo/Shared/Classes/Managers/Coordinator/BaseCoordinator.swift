//
//  BaseCoordinator.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 25/05/2024.
//

import UIKit

class BaseCoordinator<ResultType>: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var finishCallback: ((ResultType) -> Void)?
    
    internal let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {}
    
    func finish() {}
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
    }
    
    func startChildCoordinator<T>(coordinator: BaseCoordinator<T>, finishHandler: @escaping (T) -> Void) {
        addChildCoordinator(coordinator)
        coordinator.finishCallback = finishHandler
        coordinator.start()
    }
    
    func navigate<T: NavigationDestination>(to destination: T, using router: Router) {}
    
    deinit {
        print("\(self) deinitialized")
    }
}
