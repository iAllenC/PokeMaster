//
//  FrameAndLayout.swift
//  PokeMaster
//
//  Created by Dsee.Lab on 2020/9/23.
//

import SwiftUI

struct FrameAndLayout: View {
    
    var view1: some View {
        HStack(alignment: .center) {
            Text("User:")
                .font(.footnote)
                .background(Color.red)
                .alignmentGuide(.leading, computeValue: { dimension in
                    10
                })
                .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                    dimension[.bottom] + (dimension[.leading] ?? 0 )
                })
            Image(systemName: "person.circle")
                .background(Color.yellow)
            Text("iAllenChen | Chen Yuanbing")
                .layoutPriority(1)
                .background(Color.green)
        }
        .lineLimit(1)
        .fixedSize()
        .frame(width: 300, alignment: .leading)
        .background(Color.purple)
    }
    
    @State var selectedIndex = 0
    
    let names = [
        "onevcat | Wei Wang",
        "zaq | Hao Zang",
        "tyyqa | Lixiao Yang"
    ]
    
    var view2: some View {
        HStack(alignment: .select) {
            Text("User:")
                .font(.footnote)
                .foregroundColor(.green)
//                .alignmentGuide(.select, computeValue: { dimension in
//                    dimension[.bottom] + CGFloat(selectedIndex) * 20.3
//                })
            Image(systemName: "person.circle")
                .foregroundColor(.green)
                .alignmentGuide(.select, computeValue: { dimension in
                    dimension[VerticalAlignment.center]
                })
            VStack(alignment: .leading) {
                ForEach(0..<names.count) { index in
                    Text(names[index])
                        .foregroundColor(selectedIndex == index ? .green : .primary)
                        .onTapGesture {
                            selectedIndex = index
                        }
                        .alignmentGuide(selectedIndex == index ? .select : .center, computeValue: { dimension in
                            if selectedIndex == index {
                                return dimension[VerticalAlignment.center]
                            } else {
                                return 0
                            }
                        })
                }
            }
        }.animation(.linear(duration: 0.2))
    }
    
    var body: some View {
        view2
//        VStack(spacing: 20) {
//            view1
//            view2
//        }
    }
}

struct FrameAndLayout_Previews: PreviewProvider {
    static var previews: some View {
        FrameAndLayout()
    }
}

extension VerticalAlignment {
    
    struct MyCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 2
        }
    }
    
    static let myCenter = VerticalAlignment(MyCenter.self)
    
}

extension VerticalAlignment {
    
    struct SelectAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let select = VerticalAlignment(SelectAlignment.self)
    
}
