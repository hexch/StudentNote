////  DBEffect.swift
//  StudentsNote
//
//  Created by hexch on 2019/12/30.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation
import Combine

class DBLoadEffect:Effect{
    var dayModels :[DayModel] = []
    var cancelables :Set<AnyCancellable> = []
    func excute(_ store: Store) {
        DBService.shared.asyncLoad()
            .sink(receiveCompletion: {result in
                Logger.d(tag: .EFFECT, msg: "load:\(self.dayModels)")
                store.dispatch(.dbLoaded(models: self.dayModels))
            }, receiveValue: {value in
                Logger.d(tag: .EFFECT, msg: "load receive:\(value)")

                self.dayModels.append(contentsOf: value)
            }).store(in: &cancelables)
    }
}
class DBSaveEffect: Effect {
    var dayModels:[DayModel]
    var resultModels:[DayModel] = []
    init(models:[DayModel]) {
        self.dayModels = models
    }
    func excute(_ store: Store) {
        let _ = DBService.shared.asyncSave(models: self.dayModels)
        .sink(receiveCompletion: {result in
            Logger.d(tag: .EFFECT, msg: "save:\(self.resultModels)")

            store.dispatch(.dbSaved(models: self.resultModels))
        }, receiveValue: {value in
            Logger.d(tag: .EFFECT, msg: "save receive:\(value)")
            self.resultModels.append(contentsOf: value)
        })
    }
}
