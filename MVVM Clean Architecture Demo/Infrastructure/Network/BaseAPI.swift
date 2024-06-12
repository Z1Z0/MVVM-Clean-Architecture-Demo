//
//  BaseAPI.swift
//  OffTheEarth
//
//  Created by Ahmed Abd Elaziz on 21/03/2024.
//

import Foundation
import Combine
import Alamofire

class BaseAPI<T: EndpointType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, bearerToken: String? = nil) -> AnyPublisher<M, NetworkError>  {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        var headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        
        if let token = bearerToken {
            headers.add(.authorization(bearerToken: token))
        }
        
        let parameters = buildParameters(task: target.task)
        return Future<M, NetworkError> { promise in
            AF.request(target.baseURL + target.path,
                       method: method,
                       parameters: parameters.0,
                       encoding: parameters.1,
                       headers: headers)
            .responseDecodable(of: M.self) { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data))
                case .failure(let error):
                    print("Network Error: \(error)")
                    promise(.failure(NetworkError.customError(error.localizedDescription)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func buildParameters(task: TaskTypes) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestWithBodyParameters(let parameters, let encoding):
            return (parameters, encoding)
        case .requestWithQueryParameters(let queryParameters):
            return (queryParameters, URLEncoding.queryString)
        }
    }

}
