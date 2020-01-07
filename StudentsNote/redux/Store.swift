////  Store.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/26.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation

class Store:ObservableObject{
    @Published private(set) var state:AppState
    
    init(state:AppState){
        self.state = state
        self.dispatch(.dbLoad)
        self.dispatch(.select(date: Date(), updateDayGroup: true))
    }
    
    func dispatch(_ action:Action){
        if let effect = self.reducer(state: &state, action: action) {
            effect.excute(self)
        }
    }
    
    func reducer(state:inout AppState,action:Action)->Effect?{
        var effect :Effect? = nil
        Logger.d(tag: .ACTION, msg: action)
        switch action {
        case .select(let date, let updateDayGroup):
            state.selectedDate = date
            if updateDayGroup {
                state.updateDayGroup()
            }
        case .dbLoad:
            effect = DBLoadEffect()
        case .dbSave:
            effect = DBSaveEffect(models: state.getModels())
        case .dbLoaded(let models):
            state.setModels(models: models)
        case .dbSaved(let models):
            Logger.d(tag: .DATA, msg: models)
        case .addTask(let task,let date):
            state.add(task, to: date)
        case .editTask(let task,let date):
            state.edit(task, to: date)
        case .deleteTask(let task,let date):
            state.delete(task, to: date)
        case .addTodo(let todo,let date):
            state.add(todo, to: date)
        case .editTodo(let todo,let date):
            state.edit(todo, to: date)
        case .deleteTodo(let todo,let date):
            state.delete(todo, to: date)
        case .addMemo(let memo,let date):
            state.add(memo, to: date)
        case .editMemo(let memo,let date):
            state.edit(memo, to: date)
        case .deleteMemo(let memo,let date):
            state.delete(memo, to: date)
        }
        return effect
    }
}

extension Store {
    
    static func create(state:AppState)->Store{
        return Store(state:state)
    }
    
    static let sampleStore = create(state: AppState(selectedDate: Date()))
}
