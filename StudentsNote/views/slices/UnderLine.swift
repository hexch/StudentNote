////  UnderLine.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct UnderLine: View {
    var height :CGFloat = 1.0
       var fillColor :Color = .black
       var body:some View{
           GeometryReader { proxy in
               Path{ path in
                   let w = proxy.size.width
                   let h = proxy.size.height
                   var weight = self.height
                   if self.height > (h/3) {
                       weight =  h/3
                   }
                   let y = h - weight
                   
                   path.move(to: CGPoint(x: 0, y: h))
                   path.addLine(to: CGPoint(x: 0, y: y))
                   path.addLine(to: CGPoint(x: w, y: h))
                   path.closeSubpath()
               }
           }
       }
}

struct UnderLine_Previews: PreviewProvider {
    static var previews: some View {
        UnderLine().frame(width: 300, height: 50)
    }
}
