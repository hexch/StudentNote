////  TaskEditor.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct TaskEditor: View {
    let COMPANY = "会社"
    let EVENT =  "イベント"
    let STARTTIME = "開始時間"
    let ENDTIME = "終了時間"
    
    @EnvironmentObject var store:Store
    
    var index :Int
    var showing :Binding<Bool>
    
    
    @State var company:String = ""
    @State var event:String = ""
    @State var startTimeDate:Date = Date()
    @State var startInited :Bool = false
    
    @State var endTimeDate:Date = Date()
    @State var endInited :Bool = false
    
    var tasks:[Task]{
        self.store.state.dayModels[self.store.state.selectedDate.yyyyMMdd]?.tasks ?? []
    }
    var saveDisable :Bool{
        self.company.isEmpty || self.event.isEmpty
    }
    init(index:Int, showing:Binding<Bool>){
        self.index = index
        self.showing = showing
        if self.index != -1{
            let task = tasks[self.index]
            self.company = task.company
            self.event = task.event
            if let t = task.startDate {
                self.startInited = true
                self.startTimeDate = t
            }
            if let t = task.endDate {
                self.endInited = true
                self.endTimeDate = t
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                TitleInput(title: self.COMPANY, value: self.$company)
                TitleInput(title: self.EVENT, value: self.$event)
                TimeSelectorPad(title: self.STARTTIME,time: self.$startTimeDate, setState: self.$startInited)
                TimeSelectorPad(title: self.ENDTIME,time: self.$endTimeDate, setState: self.$endInited)
                Spacer()
            }
            .navigationBarTitle("タスク")
            .navigationBarItems(
                leading: Button(action:{
                    self.showing.wrappedValue.toggle()
                }, label:{Text("Cancel")}),
                trailing: Button(action: {
                    self.save()
                    self.showing.wrappedValue.toggle()
                }, label: {Text("保存")}).disabled(self.saveDisable)
            )
        }
    }
    fileprivate func save(){
        if self.index >= 0 && self.tasks.count > self.index {
            var task = self.tasks[self.index]
            task.company = self.company
            task.event = self.event
            if self.startInited {
                task.startDate = self.startTimeDate
            }
            if self.endInited {
                task.endDate = self.endTimeDate
            }
            self.store.dispatch(.editTask(task: task, date: self.store.state.selectedDate))
            
        }else{
            var task = Task(event:  self.event, company: self.company)
            
            if self.startInited {
                task.startDate = self.startTimeDate
            }
            if self.endInited {
                task.endDate = self.endTimeDate
            }
            self.store.dispatch(.addTask(task: task, date: self.store.state.selectedDate))
        }
        
    }
}

struct TaskEditor_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditor(index:-1,showing: .constant(true))
            .environmentObject(Store.sampleStore)
        
    }
}
