//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by 王 巍 on 2019/09/30.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import SwiftUI

struct PokemonInfoPanelOverlay: View {
    let model: PokemonViewModel
    var body: some View {
        VStack {
            Spacer()
            PokemonInfoPannel(model: model)
        }
//        .edgesIgnoringSafeArea(.bottom)

    }
}

struct OverlaySheet<Content: View>: View {
    
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    
    @GestureState private var translation = CGPoint.zero
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
            .updating($translation) { current, state, _ in
                state.y = current.translation.height
            }
            .onEnded {
                if $0.translation.height > 100 {
                    isPresented.wrappedValue = false
                }
            }
    }
    
    
    var body: some View {
        
        VStack {
            Spacer()
            makeContent()
        }
        .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))
        .animation(.interpolatingSpring(stiffness: 70, damping: 12))
        .edgesIgnoringSafeArea(.bottom)
        .gesture(panelDraggingGesture)

    }
    
}

extension View {
    func overlaySheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        overlay(OverlaySheet(isPresented: isPresented, content: content))
    }
}

