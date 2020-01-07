////  ArcTagView.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct ArcTagView: View {
    var color :Color = .black
    var body: some View {
        GeometryReader{proxy in
            Path { p in
                let w = proxy.size.width
                let h = proxy.size.height
                
                p.move(to: .init(x: 0, y: h))
                p.addLine(to: .init(x: w-2, y: h-2))
                p.addLine(to: .init(x:w, y:0))
                p.addLine(to: .init(x: w-3, y: h-3))
                p.closeSubpath()
            }
        }
    }
}

struct ArcTagView_Previews: PreviewProvider {
    static var previews: some View {
        ArcTagView()
            .frame(width: 80, height: 100)
            .padding()
            .previewLayout(.sizeThatFits)
        
    }
}
