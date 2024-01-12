//
//  Date+Extension.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

extension Date {
    var yy_MM_dd: String {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale.current
        RFC3339DateFormatter.dateFormat = "yy.MM.dd"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return RFC3339DateFormatter.string(from: self)
    }
}
