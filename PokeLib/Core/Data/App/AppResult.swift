//
//  AppResult.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

enum AppResult<T> {
    case OnLoading(Bool)
    case OnSuccess(T)
    case OnFailure(Error)
}
