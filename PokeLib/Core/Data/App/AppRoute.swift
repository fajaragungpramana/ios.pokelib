//
//  AppRoute.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Alamofire

final class AppRoute {
    
    static let shared = AppRoute()
    private init() {}
    
    func urlRequest(method: HTTPMethod, path: String, parameters: Parameters?) throws -> URLRequest {
        let url = try AppConfig.baseUrl.value().asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
