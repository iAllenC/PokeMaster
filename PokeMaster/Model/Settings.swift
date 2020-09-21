//
//  Settings.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import Foundation

class Settings: ObservableObject {
    
    enum AccountBehavior: CaseIterable {
        case register, login
    }
    
    enum Sorting: CaseIterable {
        case id, name, color, favorite
    }
    
    @Published var accountBehavior = AccountBehavior.login
    @Published var email = ""
    @Published var password = ""
    @Published var vefiryPassword = ""
    
    @Published var showEnglishName = true
    @Published var sorting = Sorting.id
    @Published var showFavoriteOnly = false
    
}

extension Settings.Sorting {
    
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
    
}

extension Settings.AccountBehavior {
    
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
    
    
}
