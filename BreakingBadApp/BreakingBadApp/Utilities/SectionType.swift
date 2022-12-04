//
//  SectionType.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 26.11.2022.
//

import Foundation

enum SectionType : Int {
    case season1 = 0
    case season2 = 1
    case season3 = 2
    case season4 = 3
    case season5 = 4
    static var count : Int { return season5.rawValue + 1}
    var header : String {
        switch self {
        case .season1:
            return "Season 1"
        case .season2:
            return "Season 2"
        case .season3:
            return "Season 3"
        case .season4:
            return "Season 4"
        case .season5:
            return "Season 5"
        
        }
    }
}
