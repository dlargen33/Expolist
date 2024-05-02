//
//  DateFormatter+Extensions.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation

public extension DateFormatter {
    static var iso8601Full: DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }
    }
    
    static var basic: DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter
        }
    }
}
