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
