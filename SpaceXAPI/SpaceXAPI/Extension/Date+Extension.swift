//
//  Date+Extension.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation

extension Date {
    
    var formattedString: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: self)
    }

    var currentUTCTimeZoneDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "dd-MM-yyyy 'at' HH:mm"
            
        return formatter.string(from: self)
    }
}
