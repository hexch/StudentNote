////  DBService.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/27.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation
import Combine
import RealmSwift


class DBService{
    enum DBError: Error {
        case dberror(error: Error)
    }
    
    static let shared = DBService()
    func asyncLoad() -> AnyPublisher<[DayModel],DBError>{
        
        Future { promise in
            DispatchQueue.global().async {
                do{
                    let realm = try Realm()
                    let items = realm.objects(DayModelItem.self)
                    Logger.d(tag: .DBSERVICE, msg: items)
                    promise(.success(self.decodeModels(items.shuffled())))
                }catch let error {
                    Logger.e(tag:.DBSERVICE,msg:"asyncLoad:\(error)")
                    promise(.failure(DBError.dberror(error: error)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func asyncSave(models:[DayModel]) -> AnyPublisher<[DayModel],DBError>{
        
        Future { promise in
            DispatchQueue.global().async {
                do{
                    let realm = try Realm()
                    
                    try realm.write {
                        realm.add(self.encodeModels(models), update: .modified)
                    }
                    let msg = "db file: \(String(describing: realm.configuration.fileURL))"
                    Logger.d(tag: .DBSERVICE, msg: msg)
                    promise(.success(models))
                }catch let error {
                    Logger.e(tag:.DBSERVICE,msg:"asyncSave:\(error)")
                    promise(.failure(DBError.dberror(error: error)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    var encodeModels:([DayModel])->[DayModelItem] = {items in
        return items.map{item in
            let date = item.date
            var tasks :[TaskItem] = []
            var todos :[TodoItem] = []
            var memos :[MemoItem] = []
            
            item.tasks.forEach{task in
                tasks.append(TaskItem(value: [task.id.uuidString,task.event,task.company,task.startDate as Any,task.endDate as Any,task.memo]))
            }
            item.todos.forEach{todo in
                todos.append(TodoItem(value:[todo.id,todo.done,todo.todo]))
            }
            item.memos.forEach{memo in
                memos.append(MemoItem(value:[memo.id,memo.memo]))
            }
            return DayModelItem(value:[item.id.uuidString, date,tasks,todos,memos])
        }
    }
    var decodeModels:([DayModelItem])->[DayModel] = {items in
        return items.map{item in
            let date = item.date
            var tasks :[Task] = []
            var todos :[Todo] = []
            var memos :[Memo] = []
            item.tasks.forEach{task in
                tasks.append(Task(id:UUID(uuidString: task.id)! ,event: task.event, company: task.company, startDate: task.startDate, endDate: task.endDate, memo: task.memo ))
            }
            item.todos.forEach{todo in
                todos.append(Todo(id:UUID(uuidString: todo.id)! ,done: todo.done, todo: todo.todo))
            }
            item.memos.forEach{memo in
                memos.append(Memo(id:UUID(uuidString: memo.id)! ,memo: memo.memo))
                
            }
            return DayModel(id:UUID(uuidString: item.id)!, date: date, tasks: tasks, todos: todos, memos: memos)
        }
    }
    
}
