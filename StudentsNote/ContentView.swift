////  ContentView.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/26.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store:Store
    @State private var index :Int = 1
    var selectedModel:DayModel? {self.store.state.dayModels[self.store.state.selectDate.yyyyMMdd]}
    
    var dayViews :[DayView]{
        self.store.state.dayGroup.map{DayView(date: $0)}
    }
    
    var body: some View {
        VStack{
            DayGroupScrollView()
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(self.dayViews) {$0}
                }
            }
            
            HScrollView(offset: .constant(0) ){
                ForEach(self.dayViews) {$0}
            }
            
            Text("\(self.selectedModel?.tasks.count ?? 0)")
            Button(action: {
                self.store.dispatch(.select(date: Date(), updateDayGroup: true))
            }){
                Text("SelectDate")
            }.padding()
            Button(action: {
                self.store.dispatch(.addTask(task: Task(event: "test event", company: "test company"), date: Date()))
            }){
                Text("addText")
            }.padding()
            Button(action:{
                self.editTask()
            }){
                Text("editText")
            }.padding()
            Button(action:{
                self.store.dispatch(.dbSave)
            }){
                Text("save")
            }
            Button(action:{
                self.printlog()
            }){
                Text("printlog")
            }.padding()
        }.onAppear(perform: self.printlog)
    }
    func printlog(){
        Logger.d(tag: .DATA, msg: self.store.state)
    }
    
    func editTask()
    {
        let model = self.store.state.dayModels[self.store.state.selectDate.yyyyMMdd]
        let task = model?.tasks.first
        guard let _ = model,let _ = task else {
            return
        }
        
        let editTask = Task(id: task!.id, event: "edit event", company: "edit task", startDate: Date(), endDate: Date(), memo: "memo")
        self.store.dispatch(.editTask(task: editTask, date: Date()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
