//
//  EndpointType.swift
//  OffTheEarth
//
//  Created by Ahmed Abd Elaziz on 21/03/2024.
//

import Foundation
import Alamofire

protocol EndpointType {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: TaskTypes {get}
    var headers: [String: String]? {get}
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum TaskTypes {
    case requestPlain
    case requestWithBodyParameters(parameters: [String: String], encoding: ParameterEncoding)
    case requestWithQueryParameters(queryParameters: [String: String])
}

extension EndpointType {
    
    var baseURL: String {
        return NetworkConfiguration.shared.baseURL
    }
}
