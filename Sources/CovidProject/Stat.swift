//
//  Day.swift
//  
//
//  Created by Kevin Wood on 2/28/21.
//

import Foundation

class Stat: Codable {
    private let dateInt: Int
    let positive: Int
    let death: Int
    private var dateString: String {
        let dateString = "\(dateInt)"
        let year = dateString.splitString(startIndex: 0, endIndex: 3)
        let month = dateString.splitString(startIndex: 4, endIndex: 5)
        let day = dateString.splitString(startIndex: 6, endIndex: 7)
        return "\(year)-\(month)-\(day)"
    }
    var date: Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        return date
    }
    
    
    enum CodingKeys: String, CodingKey {
        case dateInt = "date"
        case positive
        case death
        case dateString
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dateInt = try container.decode(Int.self, forKey: .dateInt)
        self.positive = try container.decodeIfPresent(Int.self, forKey: .positive) ?? 0
        self.death = try container.decodeIfPresent(Int.self, forKey: .death) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateString, forKey: .dateString)
        try container.encode(death, forKey: .death)
        try container.encode(positive, forKey: .positive)
    }
    
    static func ==(lhs: Stat, rhs: Stat) -> Bool {
        lhs.date == rhs.date &&
            lhs.positive == rhs.positive &&
            lhs.death == rhs.death &&
            lhs.date == rhs.date
    }
    
    enum State: String, Codable, CaseIterable {
        case alabama = "AL"
        case alaska = "AK"
        case arizona = "AZ"
        case arkansas = "AR"
        case california = "CA"
        case colorado = "CO"
        case connecticut = "CT"
        case delaware = "DE"
        case dc = "DC"
        case florida = "FL"
        case georgia = "GA"
        case hawaii = "HI"
        case idaho = "ID"
        case illinois = "IL"
        case indiana = "IN"
        case iowa = "IA"
        case kansas = "KS"
        case kentucky = "KY"
        case louisiana = "LA"
        case maine = "ME"
        case maryland = "MD"
        case massachusetts = "MA"
        case michigan = "MI"
        case minnesota = "MN"
        case mississippi = "MS"
        case missouri = "MO"
        case montana = "MT"
        case nebraska = "NE"
        case nevada = "NV"
        case newhampsire = "NH"
        case newjersey = "NJ"
        case newmexico = "NM"
        case newyork = "NY"
        case northcarolina = "NC"
        case northdakota = "ND"
        case ohio = "OH"
        case oklahoma = "OK"
        case oregon = "OR"
        case pennsylvania = "PA"
        case rhodeisland = "RI"
        case southcarolina = "SC"
        case southdakota = "SD"
        case tennessee = "TN"
        case texas = "TX"
        case utah = "UT"
        case vermont = "VT"
        case virginia = "VA"
        case washington = "WA"
        case westvirginia = "WV"
        case wisconsin = "WI"
        case wyoming = "WY"
    }
}
