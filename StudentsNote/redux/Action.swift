////  Action.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/26.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation

enum Action {
    case addTask(task:Task,date:Date)
    case editTask(task:Task,date:Date)
    case deleteTask(task:Task,date:Date)
    case addTodo(todo:Todo,date:Date)
    case editTodo(todo:Todo,date:Date)
    case deleteTodo(todo:Todo,date:Date)
    case addMemo(memo:Memo,date:Date)
    case editMemo(memo:Memo,date:Date)
    case deleteMemo(memo:Memo,date:Date)
    case dbLoaded(models:[DayModel])
    case dbSaved(models:[DayModel])
    case dbLoad,dbSave
    case select(date:Date,updateDayGroup:Bool = false)
}
