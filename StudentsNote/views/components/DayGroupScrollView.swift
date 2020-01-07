////  DayGroupScrollView.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/02.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct DayGroupScrollView: View {
    @EnvironmentObject var store:Store
    
    private let itemWidth :CGFloat = 30.0
    var selectedModel:DayModel? {self.store.state.dayModels[self.store.state.selectDate.yyyyMMdd]}
    
    var dayViews :[DayView]{
        self.store.state.dayGroup.map{DayView(date: $0)}
    }
    var initOffset :CGFloat{
        -(CGFloat(self.dayViews.firstIndex(where: {$0.date.isToday()})!) * self.itemWidth)
    }
    @State private var offset :CGFloat = 0
    var body: some View {
        
        HScrollView(offset: self.$offset, itemWidth: self.itemWidth ){
            ForEach(self.dayViews) { dayView in
                dayView.simultaneousGesture(
                    TapGesture().onEnded{
                        self.store.dispatch(.select(date: dayView.date))
                })
            }
        }.onAppear(perform: {
            self.offset = self.initOffset
        })
    }
}

struct DayGroupScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DayGroupScrollView()
    }
}
