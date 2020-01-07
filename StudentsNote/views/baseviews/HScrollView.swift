////  HScrollView.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/02.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct HScrollView<Content:View>: View {
    var offset: Binding<CGFloat>
    @State private var isGestureActive: Bool = false
    @State private var activeOffset :CGFloat = 0
    
    let itemWidth:CGFloat
    var content :Content
    
    @inlinable public init(offset:Binding<CGFloat>,itemWidth:CGFloat = 30.0 ,@ViewBuilder content: @escaping () -> Content){
        self.itemWidth = itemWidth
        self.offset = offset
        self.content = content()
    }
    
    @State var myoffset:CGFloat = CGFloat(-100.0)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 3) {
                self.content
            }
            .offset(x:self.isGestureActive ? self.activeOffset : self.offset.wrappedValue)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(self.scrollGesture)
        }
    }
    
    var scrollGesture :some Gesture{
        var activeAnim :Animation?{
            return self.activeOffset > 0 ? nil : Animation.default
        }
        return DragGesture().onChanged{value in
            self.isGestureActive = true
            withAnimation(activeAnim){
                self.activeOffset = self.offset.wrappedValue + value.translation.width
            }
            print("onChanged activeOffset :\(self.activeOffset )offset:\(self.offset)")
            
        }
        .onEnded{value in
            var newOffset = self.offset.wrappedValue + value.predictedEndTranslation.width
            if newOffset > 0 {
                newOffset = 0
            }
            withAnimation {
                self.offset.wrappedValue  = newOffset
            }
            DispatchQueue.main.async {
                self.isGestureActive = false
                self.activeOffset = 0
            }
        }
        
    }
    
}
//
//struct HScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        let dayViews :[DayView] = (1...50).map{_ in DayView(date: Date()}
//        
//        return HScrollView(offset:.constant(0) ){
//            ForEach(dayViews) {$0}
//        }
//    }
//}
