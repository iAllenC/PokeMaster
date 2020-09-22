//
//  AppAction.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation

enum AppAction {
    case register(email: String, password: String)
    case login(email: String, password: String)
    case logout
    case accountBehaviorDone(result: Result<User, AppError>)
    case emailValid(valid: Bool)
    case loginValid(valid: Bool)
    case registerValid(valid: Bool)
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
    case cleanCache
    case expandPokemonIndex(index: Int)
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)
}
