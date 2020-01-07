////  Logger.swift
//  JHNote
//
//  Created by hexch on 2019/11/20.
//  github:https://github.com/hexch
//
//  Copyright © 2019 Hexch. All rights reserved.
//

import Foundation
final class Logger {
    enum Tag {
        case VIEW
        case DATA
        case ACTION
        case EFFECT
        case DBSERVICE
    }
    enum Level {
        case trace
        case info
        case debug
        case warning
        case error
    }
    
    static func t<T>(tag:Tag, msg:T, file : String = #file, funcName : String = #function, lineNum : Int = #line){
        out(level: .trace, tag: tag, msg: msg, file: file, funcName: funcName, lineNum: lineNum)
    }
    
    static func i<T>(tag:Tag, msg:T, file : String = #file, funcName : String = #function, lineNum : Int = #line){
        out(level: .info, tag: tag, msg: msg, file: file, funcName: funcName, lineNum: lineNum)
    }
    
    static func d<T>(tag:Tag, msg:T, file : String = #file, funcName : String = #function, lineNum : Int = #line){
        out(level: .debug, tag: tag, msg: msg, file: file, funcName: funcName, lineNum: lineNum)
    }
    
    static func w<T>(tag:Tag, msg:T, file : String = #file, funcName : String = #function, lineNum : Int = #line){
        out(level: .warning, tag: tag, msg: msg, file: file, funcName: funcName, lineNum: lineNum)
    }
    
    static func e<T>(tag:Tag, msg:T, file : String = #file, funcName : String = #function, lineNum : Int = #line){
        out(level: .error, tag: tag, msg: msg, file: file, funcName: funcName, lineNum: lineNum)
    }
    
    fileprivate static func out<T>(level:Level,tag:Tag, msg:T, file : String, funcName : String, lineNum : Int){
        let timestamp = Date().format("yyyyMMdd hh:mm:ss.SSS") ?? ""
        let outmsg = "\(timestamp) #\(level) [\(tag)] \(msg)"
        
        print(outmsg)
    }
}
