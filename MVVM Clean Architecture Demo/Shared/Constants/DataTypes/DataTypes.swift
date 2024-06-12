//
//  DataTypes.swift
//  Clean architecture demo
//
//  Created by Ahmed Abd Elaziz on 29/04/2024.
//

import Combine

typealias PublisherResponse<T: Codable> = AnyPublisher<T, NetworkError>
typealias ResultResponse<T: Codable> = Result<T, NetworkError>
typealias ResultResponseCompletion<M: Codable> = ((ResultResponse<M>) -> Void)
typealias AppCancellable = Set<AnyCancellable>
