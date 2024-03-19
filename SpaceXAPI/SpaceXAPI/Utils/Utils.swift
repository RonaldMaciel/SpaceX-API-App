//
//  Utils.swift
//  SpaceXAPI
//
//  Created by Ronald on 17/03/24.
//

import Foundation

// MARK: - Format Date Helper
enum DateFormat {
    case shortDate
    case longDate
    case shortDateAndTime
    case longDateAndTime
    case time
}

func formatDate(from inputDate: String, as dateFormat: DateFormat = DateFormat.shortDateAndTime, timeZone: String? = nil) -> String {
    
    let formatter = DateFormatter()
    if let timeZone = timeZone {
        formatter.timeZone = TimeZone(abbreviation: timeZone)
    }
    
    switch dateFormat {
    case .shortDate:
        formatter.dateFormat = "d MMM yyyy"
    case .longDate:
        formatter.dateFormat = "d MMMM yyyy"
    case .shortDateAndTime:
        formatter.dateFormat = "d MMM yyyy, HH:mm"
    case .longDateAndTime:
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
    case .time:
        formatter.dateFormat = "HH:mm"
    }
    
    if let date = Dates.dateFromISO8601(inputDate) {
        return formatter.string(from: date)
    } else {
        return "Bad date"
    }
}

struct Dates {
    static func dateFromISO8601(_ inputDate: String) -> Date? {
        let dateFormatterStart = ISO8601DateFormatter()
        dateFormatterStart.formatOptions.insert(.withFractionalSeconds)
        
        return dateFormatterStart.date(from: inputDate)
    }
}
