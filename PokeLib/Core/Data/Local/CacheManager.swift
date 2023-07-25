//
//  CacheManager.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import Foundation

final class CacheManager {
    
    static let shared = CacheManager()
    private init() {}
    
    private static let IS_DATABASE_MANAGER_CREATED = "IS_DATABASE_MANAGER_CREATED"
    
    var isDatabaseManagerCreated: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: CacheManager.IS_DATABASE_MANAGER_CREATED)
        }
        get {
            return UserDefaults.standard.bool(forKey: CacheManager.IS_DATABASE_MANAGER_CREATED)
        }
    }
    
}
