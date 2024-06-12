//
//  Coordinator.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 01/06/2024.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
