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
    
    var publisher: AnyPublisher<[AbilityViewModel], AppError> {
        guard let url = pokemon.abilities.first?.ability.url else { return Fail(error: AppError.dataError(message: "该Pokemon没有技能~~")).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .print("[Load Abilities]")
            .decode(type: [AbilityViewModel].self, decoder: appDecoder)
            .mapError { AppError.networkingFailed(error: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
