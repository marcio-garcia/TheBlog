//
//  Date+Formatter.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Foundation

extension Date {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()

    public static func date(from timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }

    public static func date(from string: String,
                            format: String = "yyyy-MM-dd HH:mm:ss Z",
                            timeZone: TimeZone = TimeZone.current,
                            locale: Locale = Locale.current) -> Date? {
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }

    public static func string(from date: Date,
                              format: String = "yyyy-MM-dd HH:mm:ss Z",
                              timeZone: TimeZone = TimeZone.current,
                              locale: Locale = Locale.current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
