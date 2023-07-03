//
//  AppClient.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

import Alamofire
import RxSwift

class AppClient {
    
    private static let mBaseUrl = "https://pokeapi.co/api/v2/"
    
    static let shared = AppClient()
    private init() {}
    
    func urlRequest(method: HTTPMethod, path: String, parameters: Parameters) throws -> URLRequest {
        let url = try AppClient.mBaseUrl.asURL()
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
    
    func request<T : Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible)
            request.validate(statusCode: 200...300)
            request.responseDecodable(of: T.self) { response in
                let result = response.result
                    
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
                
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
