//
//  DateHelper.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 05/01/2021.
//

import Foundation

class DateHelper {
    
    static func convert(date: String, to: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from:date) else { return nil }
        dateFormatter.dateFormat = to
        let displayDate = dateFormatter.string(from: date)
        return displayDate
    }

}
