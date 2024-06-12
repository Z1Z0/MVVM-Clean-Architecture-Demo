//
//  NavigationCoordinator.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 01/06/2024.
//

import Foundation

protocol NavigationCoordinator: Coordinator {
    func navigate<T: NavigationDestination>(to destination: T, using router: Router)
}
