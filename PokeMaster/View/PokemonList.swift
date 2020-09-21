//
//  PokemonList.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    @State var keywords: String = ""
    
    var body: some View {
        // List(目前来说是UITableView)暂时无法优雅地隐藏分割线和Inset
//        List(PokemonViewModel.all) { item in
//            PokemonInfoRow(model: item, expanded: item.id == expandingIndex)
//                .modifier(ExpandModifier() {
//                    expandingIndex = item.id == expandingIndex ? nil : item.id
//                })
//        }
        // ScrollView的问题在于没有重用,数据量大的时候不可以使用
        ScrollView {
            TextField("搜索", text: $keywords)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.pokemonGray, style: StrokeStyle(lineWidth: 1))
                )
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            ForEach (PokemonViewModel.all.filter { keywords.isEmpty || $0.name.lowercased().contains(keywords.lowercased()) || $0.nameEN.lowercased().contains(keywords.lowercased()) }) { item in
                PokemonInfoRow(model: item, expanded: item.id == expandingIndex)
                    .modifier(ExpandModifier() {
                        expandingIndex = item.id == expandingIndex ? nil : item.id
                    })

            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPannel(model: .sample(id: 1))
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        )
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
    
    var body: some View {
        NavigationView {
            PokemonList()
                .navigationTitle("宝可梦列表")
        }
    }
    
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListRoot()
    }
}
