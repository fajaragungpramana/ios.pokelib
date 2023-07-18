//
//  AppService.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Alamofire
import RxSwift

class AppService {
    
    func request<T: Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
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
            
            return Disposables.create { request.cancel() }
        }
    }
    
}
