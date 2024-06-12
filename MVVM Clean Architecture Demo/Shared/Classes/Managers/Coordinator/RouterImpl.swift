//
//  RouterImpl.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 25/05/2024.
//

import UIKit

class RouterImpl: Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated, completion: nil)
    }
}
