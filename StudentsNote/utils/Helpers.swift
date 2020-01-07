//
//  Helpers.swift
//  PokeMaster
//
//  Created by Wang Wei on 2019/08/20.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension URL {
    var extractedID: Int? {
        Int(lastPathComponent)
    }
}

extension String {
    var newlineRemoved: String {
        return split(separator: "\n").joined(separator: " ")
    }
    
    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension DateFormatter {
    static let baseFormater :DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy.MM.dd hh:mm:ss"
        return formatter
    }()
}
extension Date{
    init(_ year:Int,month:Int,day:Int){
        var comp = DateComponents()
        comp.year = year
        comp.month = month
        comp.day = day
        self.init(timeInterval:0,since :Calendar.current.date(from:comp)!)
    }
    
    var yyyyMMdd :String{ self.format("yyyyMMdd")!    }
    
    var firstDayOfMonth:Date{ Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!}
    
    var daysOfMonth:[Date]{Calendar.current.range(of: .day, in: .month, for: firstDayOfMonth)!.map{Calendar.current.date(byAdding:.day, value: $0-1, to: firstDayOfMonth)!}}
    
    static var WEEKDAYSYMBOLS:[String]{
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja")
        return calendar.shortWeekdaySymbols
    }
    var weekday:String{
        return Date.WEEKDAYSYMBOLS[weekdayIndex]
    }
    var weekdayIndex:Int{
        return Calendar.current.component(.weekday, from: self)-1
    }
    
    func isSameDay(_ date:Date)->Bool{
        return Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedSame
    }
    
    func isToday()->Bool{
        return isSameDay(Date())
    }
    
    func format(_ formatter:String = "yyyy.MM.dd")->String?{
        let f = DateFormatter()
        f.dateFormat = formatter
        return f.string(from: self)
    }
    
    static func generate(date:String,formatter:String = "HH.mm")->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from:date)
    }
}
let appDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .formatted(DateFormatter.baseFormater)
    return decoder
}()

let appEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .formatted(DateFormatter.baseFormater)
    return encoder
}()


import Combine
extension Array where Element: Publisher {
    var zipAll: AnyPublisher<[Element.Output], Element.Failure> {
        let initial = Just([Element.Output]())
            .setFailureType(to: Element.Failure.self)
            .eraseToAnyPublisher()
        return reduce(initial) { result, publisher in
            result.zip(publisher) { $0 + [$1] }.eraseToAnyPublisher()
        }
    }
}
