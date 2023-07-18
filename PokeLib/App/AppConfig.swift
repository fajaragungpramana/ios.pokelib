//
//  AppConfig.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Foundation

enum AppConfig {
    case baseUrl
    
    func value() -> String {
        switch self {
        case .baseUrl:
            return dictionary(for: "BASE_URL")
        }
    }
    
    private func dictionary(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }
    
}
