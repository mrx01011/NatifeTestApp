//
//  DateManager.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import Foundation

final class DateManager {
    func timeAgoSinceDate(_ unixTimestamp: TimeInterval) -> String {
        let currentDate = Date()
        let timestampDate = Date(timeIntervalSince1970: unixTimestamp)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: timestampDate, to: currentDate)
        
        if let days = components.day, days > 0 {
            if days == 1 {
                return "\(days) day ago"
            } else {
                return "\(days) days ago"
            }
        } else if let hours = components.hour, hours > 0 {
            if hours == 1 {
                return "\(hours) hour ago"
            } else {
                return "\(hours) hours ago"
            }
        } else if let minutes = components.minute, minutes > 0 {
            if minutes == 1 {
                return "\(minutes) minute ago"
            } else {
                return "\(minutes) minutes ago"
            }
        } else {
            return "just now"
        }
    }
}
