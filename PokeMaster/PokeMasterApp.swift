//
//  PokeMasterApp.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

@main
struct PokeMasterApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonList()
        }
    }
}

struct PokeMasterApp_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
