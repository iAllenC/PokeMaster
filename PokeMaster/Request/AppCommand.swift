//
//  AppCommand.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

struct RegisterCommand: AppCommand {
    let email: String
    let password: String

    func execute(in store: Store) {
        let token = SubscriptionToken()
        RegisterRequest(email: email, password: password)
            .publisher
            .sink {
                if case .failure(let error) = $0 {
                    #if DEBUG
                    print(error)
                    #endif
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: {
                store.dispatch(.accountBehaviorDone(result: .success($0)))
            }
            .seal(in: token)
    }
    
}

struct LoginCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
            .publisher
            .sink {
                if case .failure(let error) = $0 {
                    #if DEBUG
                    print(error)
                    #endif
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: {
                #if DEBUG
                print($0)
                #endif
                store.dispatch(.accountBehaviorDone(result: .success($0)))
            }
            .seal(in: token)
    }
    
}

struct LoadPokemonsCommand: AppCommand {
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadPokemonRequest.all
            .sink {
                if case .failure(let error) = $0 {
                    store.dispatch(.loadPokemonsDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: {
                store.dispatch(.loadPokemonsDone(result: .success($0)))
            }
            .seal(in: token)
    }
    
}

struct LoadAbilitiesCommand: AppCommand {
    
    let pokemon: Pokemon
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadAbilitiesReqeust(pokemon: pokemon).publisher
            .sink {
                if case .failure(let error) = $0 {
                    store.dispatch(.loadAbilitiesDone(result: .failure(error)))
                }
                token.unseal()
            } receiveValue: {
                store.dispatch(.loadAbilitiesDone(result: .success($0)))
            }
            .seal(in: token)

    }
    
}

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
    
}
