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
    
    var selectedModel:DayModel? {self.store.state.dayModels[self.store.state.selectedDate.yyyyMMdd]}
    
    var dayViews :[DayView]{
        self.store.state.dayGroup.map{DayView(date: $0)}
    }
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:3){
                ForEach(self.dayViews) { dayView in
                    dayView.simultaneousGesture(
                        TapGesture().onEnded{
                            self.store.dispatch(.select(date: dayView.date))
                    })
                }
            }
        }
    }
}

struct DayGroupScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DayGroupScrollView()
            .environmentObject(Store.sampleStore)
            .previewLayout(.sizeThatFits)
    }
}
