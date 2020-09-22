//
//  MainTab.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView {
            PokemonListRoot()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
        }
        .environmentObject(Store())
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
