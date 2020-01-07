////  MainPage.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var store:Store
    @State var showTaskEditor = false
    @State var showCalendar = false
    
    var titleDate:String{
        self.store.state.selectedDate.format("yyyy.MM.dd") ?? ""
    }
    
    var tasks:[Task]{
        self.store.state.dayModels[self.store.state.selectedDate.yyyyMMdd]?.tasks ?? []
    }
    var body: some View {
        ZStack {

            NavigationView{
                
                VStack{
                    DayGroupScrollView()
                    Divider()
                    ForEach(tasks){task in
                        TaskContentView(event: task.event, company: task.company, edit: "", timerange: "")
                        .frame(height: 80)
                    }
                    Spacer()
                }
                .navigationBarTitle(Text(self.titleDate), displayMode: .inline)
                .navigationBarItems(leading: CalendarButtonView(show:self.$showCalendar),trailing: PlusButtonView(show: self.$showTaskEditor))
            }
            
            if self.showTaskEditor {
                TaskEditor(index: -1, showing: self.$showTaskEditor)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .environmentObject(Store.sampleStore)
    }
}



struct PlusButtonView: View {
    @Binding var show:Bool
    
    var body: some View {
        Button(action: {
            self.show.toggle()
        }){
            Image(systemName: "plus")
                .padding()
        }.foregroundColor(.primary)
        
    }
}

struct CalendarButtonView: View {
    @Binding var show:Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.5, blendDuration: 0.5)){
                self.show.toggle()
            }
            
        }){
            Image(systemName: "calendar")
                .padding()
        }.foregroundColor(.primary)
    }
}
