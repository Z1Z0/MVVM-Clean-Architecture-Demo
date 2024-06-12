//
//  NetworkError.swift
//  OffTheEarth
//
//  Created by Ahmed Abd Elaziz on 21/03/2024.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case invalidResponse
    case serverError
    case decodingError
    case customError(String)
}
