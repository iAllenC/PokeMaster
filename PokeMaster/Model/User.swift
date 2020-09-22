//
//  User.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation

struct User: Codable {
    
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemonId(_ id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
    
}
