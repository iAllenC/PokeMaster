//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct PokemonInfoRow: View {
    
    let model: PokemonViewModel
    var expanded: Bool
    
    var operationView: some View {
        HStack(spacing: expanded ? 20 : -30) {
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "star")
                    .modifier(ToolButtonModifier())
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "chart.bar")
                    .modifier(ToolButtonModifier())
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "info.circle")
                    .modifier(ToolButtonModifier())
            }
        }
        .padding(.bottom, 12)
        .opacity(expanded ? 1 : 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
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
                .frame(height: expanded ? .infinity : 0)
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
//        .onTapGesture {
//            withAnimation(
//                .spring(
//                    response: 0.55,
//                    dampingFraction: 0.425,
//                    blendDuration: 0
//                )
//            ) {
//                expanded.toggle()
//            }
//        }
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
        PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false)
        PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
    }
}
