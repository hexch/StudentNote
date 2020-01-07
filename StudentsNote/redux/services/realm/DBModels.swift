////  DBModels.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/30.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation
import RealmSwift
class TodoItem:Object{
    @objc dynamic var id :String = UUID().uuidString
    @objc dynamic var done :Bool = false
    @objc dynamic var todo :String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
class MemoItem:Object {
    @objc dynamic var id :String = UUID().uuidString
    @objc dynamic var memo :String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class TaskItem:Object{
    @objc dynamic var id :String = UUID().uuidString

    @objc dynamic var event :String = ""
    @objc dynamic var company :String = ""
    @objc dynamic var startDate:Date?
    @objc dynamic var endDate:Date?
    @objc dynamic var memo :String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class DayModelItem:Object{
    @objc dynamic var id :String = UUID().uuidString
    @objc dynamic var date:Date = Date()
    var tasks = List<TaskItem>()
    var todos = List<TodoItem>()
    var memos = List<MemoItem>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
