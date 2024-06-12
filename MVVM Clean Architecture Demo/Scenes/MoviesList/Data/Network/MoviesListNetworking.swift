//
//  MoviesListNetworking.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import Foundation
import Combine

enum MoviesListNetworking {
    case nowPlaying
    case topRated
    case upcoming
    case popular
}

extension MoviesListNetworking: EndpointType {
    
    var baseURL: String {
        switch self {
        default:
            return NetworkConfiguration.shared.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "\(NetworkConfiguration.shared.moviesBasePath)/now_playing"
        case .topRated:
            return "\(NetworkConfiguration.shared.moviesBasePath)/top_rated"
        case .upcoming:
            return "\(NetworkConfiguration.shared.moviesBasePath)/upcoming"
        case .popular:
            return "\(NetworkConfiguration.shared.moviesBasePath)/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying:
            return .get
        case .topRated:
            return .get
        case .upcoming:
            return .get
        case .popular:
            return .get
        }
    }
    
    var task: TaskTypes {
        switch self {
        case .nowPlaying:
            return .requestPlain
        case .topRated:
            return .requestPlain
        case .upcoming:
            return .requestPlain
        case .popular:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .nowPlaying:
            return nil
        case .topRated:
            return nil
        case .upcoming:
            return nil
        case .popular:
            return nil
        }
    }
    
}
