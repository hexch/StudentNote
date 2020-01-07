////  DataModels.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/29.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation

struct DayModel {
    var id = UUID()
    var date:Date
    var tasks:[Task] = []
    var todos:[Todo] = []
    var memos:[Memo] = []
}

struct Task : Identifiable,Codable,Equatable{
    
    var id = UUID()
    var event:String
    var company:String
    var startDate:Date?
    var endDate:Date?
    var memo:String = ""
    
    mutating func edit(task :Task){
        self.event = task.event
        self.company = task.company
        self.startDate = task.startDate
        self.endDate = task.endDate
        self.memo = task.memo
    }
}
struct Todo  : Identifiable,Codable{
    var id = UUID()
    var done:Bool
    var todo:String
    
    mutating func edit(todo :Todo){
        self.done = todo.done
        self.todo = todo.todo
    }
}
struct Memo  : Identifiable,Codable{
    var id = UUID()
    var memo:String
    
    mutating func edit(memo :Memo){
        self.memo   = memo.memo
    }
}
