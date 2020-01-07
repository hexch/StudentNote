////  PowerScroll.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/02.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI


struct PowerScroll<Content: View & Identifiable>: View {
    
    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isGestureActive: Bool = false
    
    let pageWidth:CGFloat
    // 1
    var pages: [Content]
    var action: (Content)->Void
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack(alignment: .center, spacing: 0) {
                ForEach(self.pages) { page in
                    
                    page.frame(width: self.pageWidth, alignment: .center)
                        .simultaneousGesture(TapGesture().onEnded{value in self.action(page)})
                    
                }
            }
            .offset(x: self.isGestureActive ? self.offset : -self.pageWidth * CGFloat(self.index))
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .gesture(DragGesture().onChanged({ value in
                self.isGestureActive = true
                self.offset = value.translation.width + (-self.pageWidth) * CGFloat(self.index)
                print("onChanged")
                print(self.offset)
            }).onEnded({ value in
                print("onEnded")
                let incress = Int(value.predictedEndTranslation.width / (self.pageWidth/2))/2
                self.index -= incress
                
                if self.index > (self.pages.endIndex - Int(geometry.size.width / self.pageWidth)-1) {
                    self.index = self.pages.endIndex - Int(geometry.size.width/self.pageWidth)-1
                }
                if self.index < 0 {
                    self.index = 0
                }
                // 6
                withAnimation { self.offset = -(self.pageWidth) * CGFloat(self.index) }
                // 7
                DispatchQueue.main.async { self.isGestureActive = false }
            })
            )
        }
    }
}

