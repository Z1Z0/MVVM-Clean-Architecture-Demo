//
//  Router.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 01/06/2024.
//

import UIKit

protocol Router {
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}
