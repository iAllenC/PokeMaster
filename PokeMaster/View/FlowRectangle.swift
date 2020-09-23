//
//  FlowRectangle.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/23.
//

import SwiftUI

struct FlowRectangle: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
            Text("User:")
            Text("onevcat | Wei Wang")
        }
        .lineLimit(1)
        .frame(width: 200, height: 10)
//        GeometryReader { proxy in
//            Rectangle()
//                .stroke(style: StrokeStyle(lineWidth: 1))
//                .background(Color.gray.opacity(0.5))
//            Circle()
//                .path(
//                    in: CGRect(
//                        x: -proxy.size.width,
//                        y: 0,
//                        width: proxy.size.width,
//                        height: proxy.size.height)
//                )
//                .fill(Color.blue)
//            Circle()
//                .path(
//                    in: CGRect(
//                        x: 0,
//                        y: -proxy.size.height,
//                        width: proxy.size.width,
//                        height: proxy.size.height)
//                )
//                .fill(Color.red)
//            Circle()
//                .path(
//                    in: CGRect(
//                        x: proxy.size.width,
//                        y: 0,
//                        width: proxy.size.width,
//                        height: proxy.size.height)
//                )
//                .fill(Color.yellow)
//            Circle()
//                .path(
//                    in: CGRect(
//                        x: 0,
//                        y: proxy.size.height,
//                        width: proxy.size.width,
//                        height: proxy.size.height)
//                )
//                .fill(Color.green)
//
//
//        }
//        .frame(width: 100, height: 100)
    }
}

struct FlowRectangle_Previews: PreviewProvider {
    static var previews: some View {
        FlowRectangle()
    }
}
