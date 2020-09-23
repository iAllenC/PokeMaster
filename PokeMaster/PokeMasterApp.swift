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
            MainTab().environmentObject(Store())
        }
    }
    
}

extension PokeMasterApp {
    func createStore(_ URLContexts: Set<UIOpenURLContext>) -> Store {
        let store = Store()
        guard let url = URLContexts.first?.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return store }
        switch (components.scheme, components.host) {
        case ("pokemaster", "showPanel"):
            guard let idQuery = components.queryItems?.first(where: { $0.name == "id" }),
                  let idString = idQuery.value,
                  let id = Int(idString),
                  id >= 1 && id <= 30 else {
                break
            }
            store.appState.pokemonList.selectionState = .init(expandingIndex: id, panelIndex: id, panelPresented: true)
        default:
            break
        }
        return store
    }

}

struct PokeMasterApp_Previews: PreviewProvider {
    static var previews: some View {
        MainTab().environmentObject(Store())
    }
}
