//
//  PokemonInfoPannel.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct PokemonInfoPannel: View {
    
    let model: PokemonViewModel
    
    @State var blurStyle = UIBlurEffect.Style.systemMaterial
    
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var topIndicatorView: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 8)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    var body: some View {
        VStack(spacing: 20) {
            topIndicatorView
            Button("改变模糊效果") {
                print("改变模糊效果")
                blurStyle = blurStyle == .systemMaterial ? .systemMaterialDark : .systemMaterial
            }
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
//        .background(Color.white)
        .blurBackground(style: blurStyle)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPannel {
    
    struct Header: View {
        
        let model: PokemonViewModel
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies: some View {
            VStack {
                Text(model.name)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(model.color)
                Text(model.nameEN)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(model.color)
                Text(model.genus)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
        }
        
        var bodyInfo: some View {
            VStack {
                HStack {
                    Text("身高")
                        .foregroundColor(.pokemonGray)
                        .font(.system(size: 11))
                    Text(model.height)
                        .foregroundColor(.pokemonGreen)
                        .font(.system(size: 11))
                }
                HStack {
                    Text("体重")
                        .foregroundColor(.pokemonGray)
                        .font(.system(size: 11))
                    Text(model.weight)
                        .foregroundColor(.pokemonGreen)
                        .font(.system(size: 11))
                }

            }
        }
        
        var typeInfo: some View {
            HStack {
                ForEach(model.types) {
                    Text($0.name)
                        .foregroundColor(.white)
                        .font(.system(size: 11))
                        .frame(width: 36, height: 14)
                        .background($0.color)
                        .cornerRadius(7)
                }
            }
        }
        
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                Divider()
                    .background(Color.pokemonGray)
                    .frame(width: 1, height: 44)
                VStack(spacing: 10) {
                    bodyInfo
                    typeInfo
                }
            }
        }
        
    }
    
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if abilityModels != nil {
                    ForEach(abilityModels!) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct PokemonInfoPannel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPannel(model: .sample(id: 1))
            
    }
}
