//
//  IndicatorView.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/22.
//

import Foundation
import SwiftUI

struct IndicatorView: UIViewRepresentable {
    
    let color: UIColor

    func makeUIView(context: UIViewRepresentableContext<IndicatorView>) -> some UIView {
        let indicator = UIActivityIndicatorView()
        indicator.color = color
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<IndicatorView>) {
        
    }
    
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(color: .black)
    }
}
