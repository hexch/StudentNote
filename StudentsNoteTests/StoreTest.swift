////  StoreTest.swift
//  StudentsNoteTests
//
//  Created by hexch on 2019/12/29.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import XCTest
@testable import StudentsNote

class StoreTest: XCTestCase {
    let selectedDate = Date()
    var store :Store = Store(state: AppState(selectedDate: Date()))
    let event = "test event"
    let company = "test company"
    let startDate = Date.generate(date: "20191230101010", formatter: "yyyyMMddHHmmss")
    let endDate = Date.generate(date: "20191230111110", formatter: "yyyyMMddHHmmss")
    let memo = "test memo"
    var task :Task?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.task = Task(event: self.event, company: self.company , startDate:self.startDate, endDate: self.endDate, memo: self.memo)
        print("setUp \(self.store.state) " )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//
//    func testTask(){
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        self.store.dispatch(.addTask(task: self.task!, date: self.selectedDate))
//
//        let result = self.store.state.dayModels[self.selectedDate]?.tasks.first(where: {$0.id == self.task!.id})
//        XCTAssertNotNil(result)
//
//        XCTAssert(result?.event == event)
//        XCTAssert(result?.company == company)
//        XCTAssert(result?.startDate == startDate)
//        XCTAssert(result?.endDate == endDate)
//        XCTAssert(result?.memo == memo)
//        print("add \(self.store.state) " )
//
//
//        let editevent = "edit event"
//
//        var target = self.store.state.dayModels[self.selectedDate]?.tasks.first(where: {$0.id == self.task!.id})
//        XCTAssertNotNil(target)
//
//        target!.event = editevent
//        self.store.dispatch(.editTask(task: target!, date: self.selectedDate))
//
//        let result1 = self.store.state.dayModels[self.selectedDate]?.tasks.first(where: {$0.id == self.task!.id})
//        XCTAssertNotNil(result1)
//
//        XCTAssert(result1?.event == editevent)
//
//        print("edit \(self.store.state) " )
//
//        target = self.store.state.dayModels[self.selectedDate]?.tasks.first(where: {$0.id == self.task!.id})
//        XCTAssertNotNil(target)
//
//        self.store.dispatch(.deleteTask(task: target!, date: self.selectedDate))
//
//       let result2 = self.store.state.dayModels[self.selectedDate]?.tasks.first(where: {$0.id == self.task!.id})
//       XCTAssertNil(result2)
//       print("testDeletTask \(self.store.state) " )
//    }
//
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
