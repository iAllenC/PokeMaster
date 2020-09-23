//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI
import KingfisherSwiftUI

struct PokemonInfoRow: View {
    
    @EnvironmentObject var store: Store
    let model: PokemonViewModel
    var expanded: Bool
    
    
    var operationView: some View {
        HStack(spacing: expanded ? 20 : -30) {
            Spacer()
            Button(action: {
                store.dispatch(.favoratePokemon(pokemon: model.pokemon))
            }) {
                Image(systemName: "star")
                    .modifier(ToolButtonModifier())
            }
            Button(action: {
                let presented = !store.appState.pokemonList.selectionState.panelPresented
                store.dispatch(.togglePanelPresenting(presenting: presented))
            }) {
                Image(systemName: "chart.bar")
                    .modifier(ToolButtonModifier())
            }
            //Present
            Button(action: {
                let displaying = !store.appState.pokemonList.isSFViewActive
                store.dispatch(.toggleSafariDisplaying(displaying: displaying))
            }) {
                Image(systemName: "info.circle")
                    .modifier(ToolButtonModifier())
            }.sheet(isPresented: expanded ? $store.appState.pokemonList.isSFViewActive : .constant(false)) {
                SafariView(url: model.detailPageURL) {
                    store.dispatch(.toggleSafariDisplaying(displaying: false))
                }
            }
            //Push
//            NavigationLink(
//                destination: SafariView(url: model.detailPageURL) { store.dispatch(.toggleSafariDisplaying(displaying: false)) }
//                    .navigationBarTitle(
//                        Text(model.name),
//                        displayMode: .inline
//                    ),
//                isActive: expanded ? $store.appState.pokemonList.isSFViewActive : .constant(false),
//                label: {
//                    Image(systemName: "info.circle")
//                        .modifier(ToolButtonModifier())
//                }
//            )
        }
        .padding(.bottom, 12)
        .opacity(expanded ? 1 : 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                KFImage(model.iconImageURL)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }.padding(.top, 12)
            Spacer()
            operationView
                .frame(height: expanded ? 42 : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(model.color, style: StrokeStyle(lineWidth: 4))
            RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                    gradient: Gradient(colors: [.white, model.color]),
                                    startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                    endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        })
        .padding(.horizontal)
        .alert(isPresented: $store.appState.pokemonList.isFavoratingUnLogged, content: {
            Alert(title: Text("需要登录"), primaryButton: .cancel(Text("取消")), secondaryButton: .default(Text("登录")) {
                store.dispatch(.gotoSettings)
            })
        })
    }
}

struct ToolButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
    
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false).environmentObject(Store())
        PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true).environmentObject(Store())
    }
}
