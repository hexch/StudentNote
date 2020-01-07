////  Effect.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/26.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation

protocol Effect {
    func excute(_ store:Store)
}
enum ModifyType {
    case add,edit,delete
}
//
//class DBEffect<Table>:Effect{
//    let modify:ModifyType
//    let table:Table
//    init(table:Table,modify:ModifyType){
//        self.modify = modify
//        self.table = table
//    }
//    
//    func excute(_ store: Store) {
//        
//    }
//}
//class TaskEffect:Effect{
//    let modify:ModifyType
//    let task:Task
//    init(task:Task,modify:ModifyType){
//        self.modify = modify
//        self.task = task
//    }
//    func excute(_ store: Store) {
//        
//    }
//}
//class AddTaskEffect:Effect{
//    var task :Task
//    init(task:Task){
//        self.task = task
//    }
//    func excute(_ store: Store) {
//        
//    }
//}
//class EditTaskEffect:Effect{
//    var task :Task
//    init(task:Task){
//        self.task = task
//    }
//    func excute(_ store: Store) {
//        
//    }
//}
//
//class DeleteTaskEffect:Effect{
//    var task :Task
//    init(task:Task){
//        self.task = task
//    }
//    func excute(_ store: Store) {
//        
//    }
//}
//
