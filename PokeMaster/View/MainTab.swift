//
//  MainTab.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import SwiftUI

struct MainTab: View {
    
    @EnvironmentObject var store: Store

    private var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }

    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }

    var body: some View {
        TabView(selection: $store.appState.mainTab.selection) {
            PokemonListRoot()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
                .tag(AppState.MainTab.Index.list)
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
                .tag(AppState.MainTab.Index.settings)
        }
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            if let panelIndex = selectedPanelIndex,
               let pokemons = pokemonList.pokemons,
               let pokemon = pokemons[panelIndex] {
                PokemonInfoPanelOverlay(model: pokemon)
            }
        }
    }
    
    var panel: some View {
        Group {
            if pokemonList.selectionState.panelPresented,
               let panelIndex = selectedPanelIndex,
               let pokemons = pokemonList.pokemons,
               let pokemon = pokemons[panelIndex] {
                PokemonInfoPanelOverlay(model: pokemon)
            } else {
                EmptyView()
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab().environmentObject(Store())
    }
}
