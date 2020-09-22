//
//  Store.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

class Store: ObservableObject {
    
    @Published var appState = AppState()
    private var disposeBag = [AnyCancellable]()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        let isEmailValid = appState.settings.checker.isEmailValid.share()
        isEmailValid
            .sink { isValid in
                self.dispatch(.emailValid(valid: isValid))
            }
            .store(in: &disposeBag)
        isEmailValid.combineLatest(appState.settings.checker.isPasswordMatch)
            .print("Register Valid")
            .sink {
                self.dispatch(.registerValid(valid: $0.0 && $0.1))
            }
            .store(in: &disposeBag)
        isEmailValid.combineLatest(appState.settings.checker.isPasswordValid)
            .print("Login Valid")
            .sink {
                self.dispatch(.loginValid(valid: $0.0 && $0.1))
            }
            .store(in: &disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[Action]:\(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
            print("[Command]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        case let .register(email: email, password: password):
            guard !appState.settings.registerRequesting else { break }
            appState.settings.registerRequesting = true
            appCommand = RegisterCommand(email: email, password: password)
        case let .login(email: email, password: password):
            guard !appState.settings.loginRequesting else { break }
            appState.settings.loginRequesting = true
            appCommand = LoginCommand(email: email, password: password)
        case .logout:
            appState.settings.loginRequesting = false
            appState.settings.loginUser = nil
        case .accountBehaviorDone(result: let result):
            appState.settings.registerRequesting = false
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                #if DEBUG
                print("[Error]:\(error)")
                #endif
                appState.settings.loginError = error
            }
        case .emailValid(valid: let valid):
            appState.settings.isEmailValid = valid
        case .loginValid(valid: let valid):
            appState.settings.isLoginValid = valid
        case .registerValid(valid: let valid):
            appState.settings.isRegisterValid = valid
        case .loadPokemons:
            guard !appState.pokemonList.loadingPokemons else { break }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(result: let result):
            appState.pokemonList.loadingPokemons = false
            switch result {
            case .success(let models):
                appState.pokemonList.error = nil
                appState.pokemonList.pokemons = Dictionary(uniqueKeysWithValues: models.map { ($0.id, $0) })
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
                appState.pokemonList.error = error
            }
        case .cleanCache:
            appState.pokemonList.pokemons = nil
        case .expandPokemonIndex(index: let index):
            appState.pokemonList.expandingIndex = appState.pokemonList.expandingIndex == index ? nil : index
        case .loadAbilities(pokemon: let pokemon):
            appState.pokemonList.loadingAbilities = true
            appCommand = LoadAbilitiesCommand(pokemon: pokemon)
        case .loadAbilitiesDone(result: let result):
            switch result {
            case .success(let models):
                appState.pokemonList.abilities = Dictionary(uniqueKeysWithValues: models.map { ($0.id, $0) })
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
            }
        }
        return (appState, appCommand)
    }
    
}
