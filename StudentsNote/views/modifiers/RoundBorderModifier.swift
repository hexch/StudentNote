////  RoundBorderModifier.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/01.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct RoundBorderModifier: ViewModifier {
    var color :Color = .gray
    var radius :CGFloat = 10
    var roundedBg :RoundedRectangle{
        return RoundedRectangle(cornerRadius: radius)
    }
    func body(content: Content) -> some View {
        content
            .clipShape(roundedBg)
            .overlay(roundedBg.stroke(Color.gray, lineWidth: 1))
    }
    
}
extension View{
    func roundBorder(_ radius :CGFloat = 10,color :Color = .gray)-> some View{
        self.modifier(RoundBorderModifier(color:color, radius: radius))
    }
}
