////  DBServiceTests.swift
//  StudentsNoteTests
//
//  Created by hexch on 2019/12/30.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import XCTest
@testable import StudentsNote
import Combine

class DBServiceTests: XCTestCase {
    let selectedDate = Date()
    var store :Store = Store(state: AppState(selectedDate: Date()))
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let event = "test event"
//        let company = "test company"
//        let startDate = Date.generate(date: "20191230101010", formatter: "yyyyMMddHHmmss")
//        let endDate = Date.generate(date: "20191230111110", formatter: "yyyyMMddHHmmss")
//        let memo = "test memo"
//        let task :Task  = Task(event: event, company: company , startDate:startDate, endDate: endDate, memo: memo)
//        self.store.dispatch(.addTask(task: task, date: self.selectedDate))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoad(){
        var cancellables = Set<AnyCancellable>()
        let waiter1 = XCTWaiter()
        let exp1 = XCTestExpectation()

        var models :[DayModel] = []
        DBService.shared.asyncLoad()
            .sink(receiveCompletion: {_ in
                exp1.fulfill()
            }, receiveValue: {value in
                print("asyncLoad receive value :\(value)")
                models.append(contentsOf: value)
            }).store(in: &cancellables)
        
        _ = waiter1.wait(for: [exp1], timeout: 2)
        print("asyncLoad loaded: \(models)")
        
        
        
    }
}
