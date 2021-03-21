//
//  Extensions.swift
//  
//
//  Created by Kevin Wood on 3/1/21.
//

import Foundation

extension String {
    
    func splitString(startIndex: Int, endIndex: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.endIndex, offsetBy: endIndex - self.count)
        let range = start...end

        let substring = self[range]
        return "\(substring)"
    }
}

extension Date {
    
    private var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }

    private func endOfMonth(months: Int, days: Int) -> Date {
        var components = DateComponents()
        components.month = months
        components.day = days
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var isTwoWeeksIn: Bool {
        return self == endOfMonth(months: 1, days: -15)
    }
    
    var isLastDate: Bool {
        return self == endOfMonth(months: 1, days: -1)
    }
}
