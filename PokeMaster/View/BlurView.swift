//
//  BlurView.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/21.
//

import Foundation
import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView
    {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 2
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    // 3
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        if let blurView = uiView.subviews.first(where: { $0 is UIVisualEffectView }) {
            blurView.removeFromSuperview()
        }
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 2
        blurView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: uiView.widthAnchor)
        ])
    }
}

extension View {
    
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
    
}
