////  DayView.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/01.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct DayView: View,Identifiable {
    @EnvironmentObject var store:Store
    var id: UUID = UUID()
    
    var date:Date
    var isSelected :Bool{
        self.date.isSameDay(self.store.state.selectedDate)
    }
    var w :CGFloat = 40.0
    var h :CGFloat = 50.0
    
    var body: some View {
        VStack {
            HStack {
                Text(date.weekday)
                    .foregroundColor(self.date.isToday() ? .yellow : .black)
                    .font(.caption)
                
                Spacer()
                    .padding(.trailing,10)
            }
            Text(date.format("d")!)
                .font(.title)
                .bold()
                .clipped()
                .foregroundColor(self.date.isToday() ? .yellow : .black)
            
            Spacer()
        }
        .frame(width: w , height: h, alignment: .center)
        .padding()
        .background(self.isSelected ? Color.gray : Color.white)
        .foregroundColor(Color.black)
        .roundBorder()
        .shadow(radius: 5)
        
    }
}
struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(date: Date())
    }
}
