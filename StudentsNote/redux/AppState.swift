////  AppState.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/26.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation
let dayGroupBefore:Int = 10
let dayGroupAfter:Int = 10
struct AppState {
    var selectDate:Date
    var dayGroup:[Date] = []
    var dayModels:[String:DayModel] = [:]
}
extension AppState{
    mutating func updateDayGroup(){
        self.dayGroup = (-dayGroupBefore..<dayGroupAfter)
            .map{Calendar.current.date(byAdding: .day, value: $0, to: self.selectDate)!}
    }
}
extension AppState{
    mutating func add(_ task:Task, to date:Date){
        let dateString = date.yyyyMMdd
        if !self.dayModels.keys.contains(dateString) {
            self.dayModels[dateString] = DayModel(date: date)
        }
        
        self.dayModels[dateString]?.tasks.append(task)
    }
    mutating func edit(_ task:Task, to date:Date){
        let dateString = date.yyyyMMdd
        if let index = self.dayModels[dateString]?.tasks.firstIndex(where: {$0.id == task.id}){
            self.dayModels[dateString]?.tasks[index].edit(task: task)
        }
    }
    mutating func delete(_ task:Task, to date:Date){
        let dateString = date.yyyyMMdd
        if let index = self.dayModels[dateString]?.tasks.firstIndex(where: {$0.id == task.id}){
            self.dayModels[dateString]?.tasks.remove(at: index)
        }
    }
}

extension AppState{
    mutating func add(_ element:Todo, to date:Date){
        let dateString = date.yyyyMMdd
        if !self.dayModels.keys.contains(dateString) {
            self.dayModels[dateString] = DayModel(date: date)
        }
        
        self.dayModels[dateString]?.todos.append(element)
    }
    mutating func edit(_ element:Todo, to date:Date){
        let dateString = date.yyyyMMdd
        
        if let index = self.dayModels[dateString]?.todos.firstIndex(where: {$0.id == element.id}){
            self.dayModels[dateString]?.todos[index].edit(todo: element)
        }
    }
    mutating func delete(_ element:Todo, to date:Date){
        let dateString = date.yyyyMMdd
        
        if let index = self.dayModels[dateString]?.todos.firstIndex(where: {$0.id == element.id}){
            self.dayModels[dateString]?.todos.remove(at: index)
        }
    }
}

extension AppState{
    mutating func add(_ element:Memo, to date:Date){
        let dateString = date.yyyyMMdd
        
        if !self.dayModels.keys.contains(dateString) {
            self.dayModels[dateString] = DayModel(date: date)
        }
        
        self.dayModels[dateString]?.memos.append(element)
    }
    mutating func edit(_ element:Memo, to date:Date){
        let dateString = date.yyyyMMdd
        
        if let index = self.dayModels[dateString]?.todos.firstIndex(where: {$0.id == element.id}){
            self.dayModels[dateString]?.memos[index].edit(memo: element)
        }
    }
    mutating func delete(_ element:Memo, to date:Date){
        let dateString = date.yyyyMMdd
        
        if let index = self.dayModels[dateString]?.todos.firstIndex(where: {$0.id == element.id}){
            self.dayModels[dateString]?.memos.remove(at: index)
        }
    }
}
extension AppState{
    func getModels()->[DayModel]{
        return self.dayModels.reduce([]) { var seq = $0;  seq.append($1.value); return seq}
    }
    mutating func setModels(models:[DayModel]){
        self.dayModels = models.reduce([:], {dic,model in
            var dic = dic
            let dateString = model.date.yyyyMMdd
            
            dic[dateString] = model
            return dic
        })
    }
}
