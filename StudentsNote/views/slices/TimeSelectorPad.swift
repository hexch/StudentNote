////  TimeSelectorPad.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct TimeSelectorPad: View {
    let DEFAULTTIME :String = "--:--"
    var title:String
    @Binding var time :Date
    @State var showPicker = false
    @Binding var setState:Bool
    
    var dispTime :String {
        if self.setState {
            return self.time.format("HH:mm") ?? DEFAULTTIME
        }else{
            return DEFAULTTIME
        }
    }
    
    var body: some View {
        VStack {
            
            Button(action:{
                self.showPicker.toggle()
                self.$setState.wrappedValue = true
            }){
                HStack {
                    Text(self.title)
                    Spacer()
                    Text(self.dispTime)
                }
                .padding()
                
            }.foregroundColor(.black)
            
            
            if self.showPicker {
                DatePicker(selection: self.$time, displayedComponents: .hourAndMinute, label: {EmptyView()})
            }
        }
        .roundBorder()
        .padding([.leading,.trailing,.top])
    }
}

struct TimeSelectorPad_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectorPad(title: "開始時間",time: .constant(Date()), setState: .constant(false))
    }
}
