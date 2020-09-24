//
//  PokemonList.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct PokemonListView: View {
    
    @State var keywords: String = ""
    @EnvironmentObject var store: Store
    
    var pokemonsToDisplay: [PokemonViewModel] {
        store.appState.pokemonList.allPokemonsByID
            .filter {
                keywords.isEmpty ||
                $0.name.lowercased().contains(keywords.lowercased()) ||
                $0.nameEN.lowercased().contains(keywords.lowercased())
            }
    }
    
    var pokemonScrollView: some View {
        ScrollView {
            TextField("搜索", text: $keywords)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.pokemonGray, style: StrokeStyle(lineWidth: 1))
                )
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            ForEach (pokemonsToDisplay) { item in
                PokemonInfoRow(model: item, expanded: item.id == store.appState.pokemonList.selectionState.expandingIndex)
                    .modifier(ExpandModifier() {
                        store.dispatch(.expandPokemonIndex(index: item.id))
                        store.dispatch(.loadAbilities(pokemon: item.pokemon))
                    })

            }
        }.sheet(isPresented: $store.appState.pokemonList.isSFViewActive, content: {
            if let pokemonDetailUrl = pokemonsToDisplay.first{ $0.id == store.appState.pokemonList.selectionState.expandingIndex }?
                .detailPageURL {
                SafariView(url: pokemonDetailUrl) {
                    store.dispatch(.toggleSafariDisplaying(displaying: false))
                }
            }
        })
    }
    
    var body: some View {
        if store.appState.pokemonList.error != nil {
            if store.appState.pokemonList.loadingPokemons {
                IndicatorView(color: .black)
            } else {
                Button(action: {
                    store.dispatch(.loadPokemons)
                }, label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.pokemonGray)
                        Text("Retry")
                            .foregroundColor(.pokemonGray)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.pokemonGray)
                    )
                })
            }
        } else if store.appState.pokemonList.pokemons == nil {
            Text("Loading").onAppear {
                store.dispatch(.loadPokemons)
            }
        } else {
            // List(目前来说是UITableView)暂时无法优雅地隐藏分割线和Inset
            // ScrollView的问题在于没有重用,数据量大的时候不可以使用
            pokemonScrollView
        }

    }
    
    struct ExpandModifier: ViewModifier {
        
        var completion: () -> Void
        
        func body(content: Content) -> some View {
            content.onTapGesture {
                withAnimation(
                    .spring(
                        response: 0.55,
                        dampingFraction: 0.425,
                        blendDuration: 0
                    )
                ) {
                    completion()
                }
            }
        }
        
    }
    
}

struct PokemonListRoot: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            PokemonListView()
                .navigationTitle("宝可梦列表")
        }
    }
    
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.appState.pokemonList.error = .networkingFailed(error: NSError(domain: "pokemon", code: 404, userInfo: nil))
        return PokemonListRoot().environmentObject(store)
    }
}
