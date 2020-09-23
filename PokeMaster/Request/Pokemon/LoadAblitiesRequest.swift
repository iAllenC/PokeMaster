//
//  LoadAblitiesRequest.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import Combine

struct LoadAbilitiesReqeust {
    
    let pokemon: Pokemon
    
    func ability(at url: URL) -> AnyPublisher<Ability, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .print("[Load Abilitie]")
            .decode(type: Ability.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    var publisher: AnyPublisher<[AbilityViewModel], AppError> {
        pokemon.abilities.map {
            ability(at: $0.ability.url)
        }
        .zipAll
        .map {
            $0.map(AbilityViewModel.init(ability:))
        }
        .mapError { AppError.networkingFailed(error: $0) }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}
