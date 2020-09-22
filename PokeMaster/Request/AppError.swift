//
//  AppError.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation

enum AppError: Error {
    case passwordWrong
    case networkingFailed(error: Error)
    case dataError(message: String?)
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        case .networkingFailed(let error):
            return error.localizedDescription
        case .dataError(message: let message):
            return message ?? "数据错误"
        }
    }
    
    
}

extension AppError: Identifiable {
    
    var id: String { localizedDescription }
    
}
