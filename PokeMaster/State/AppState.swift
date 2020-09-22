//
//  AppState.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

struct AppState {
    
    var settings = Settings()
    
    var pokemonList = PokemonList()
    
}

extension AppState {
    
    struct Settings {
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        switch (validEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoveVerify = $accountBehavior.map { $0 == .login }
                return Publishers.CombineLatest3(remoteVerify, emailLocalValid, canSkipRemoveVerify)
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
            
            var isPasswordValid: AnyPublisher<Bool, Never> {
                $password.map { $0.count > 6 }.eraseToAnyPublisher()
            }
            
            var isPasswordMatch: AnyPublisher<Bool, Never> {
                $password.combineLatest($verifyPassword).map {
                    !$0.0.isEmpty && !$0.1.isEmpty && $0.0 == $0.1
                }
                .eraseToAnyPublisher()
            }
        }
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
                
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }

        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        var registerRequesting: Bool = false        
        var loginRequesting: Bool = false
        var loginError: AppError?
        
        var checker = AccountChecker()
        var isEmailValid = false
        var isRegisterValid = false
        var isLoginValid = false

    }
    
}

extension AppState {
    
    struct PokemonList {
        var loadingPokemons = false
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?

        var loadingAbilities = false
        var abilities: [Int: AbilityViewModel]?
        
        var searchText: String?
        
        var expandingIndex: Int?
        
        var error: AppError?

        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else { return [] }
            return pokemons.sorted { $0.id < $1.id }
        }
        
        func ablityViewModels(for pokemon: Pokemon) -> AbilityViewModel? {
            abilities?[pokemon.id]
        }
    }
    
}
