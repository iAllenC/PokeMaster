//
//  LoadPokemonRequest.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

struct LoadPokemonRequest {
    
    let id: Int
    
    func pokemonPublisher(_ id: Int) -> AnyPublisher<Pokemon, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    func speciesPublisher(_ pokemon: Pokemon) -> AnyPublisher<(Pokemon, PokemonSpecies), Error> {
        URLSession.shared
            .dataTaskPublisher(for: pokemon.species.url)
            .map { $0.data }
            .decode(type: PokemonSpecies.self, decoder: appDecoder)
            .map { (pokemon, $0) }
            .eraseToAnyPublisher()
    }
    
    var publisher: AnyPublisher<PokemonViewModel, AppError> {
        pokemonPublisher(id)
            .flatMap { self.speciesPublisher($0) }
            .map { PokemonViewModel(pokemon: $0.0, species: $0.1) }
            .print()
            .mapError { AppError.networkingFailed(error: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static var all: AnyPublisher<[PokemonViewModel], AppError> {
        (1...30).map {
            LoadPokemonRequest(id: $0).publisher
        }.zipAll
    }
    
}

extension Array where Element: Publisher {
    
    var zipAll: AnyPublisher<[Element.Output], Element.Failure> {
        let initial = Just([Element.Output]())
            .setFailureType(to: Element.Failure.self)
            .eraseToAnyPublisher()
        return reduce(initial) { result, publisher in
            result.zip(publisher) { $0 + [$1]}
                .eraseToAnyPublisher()
        }
    }
    
}
