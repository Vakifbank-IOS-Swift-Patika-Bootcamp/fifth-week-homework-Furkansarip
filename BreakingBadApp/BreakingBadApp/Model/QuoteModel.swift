//
//  QuoteModel.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import Foundation

struct QuoteModel: Codable {
    let quoteID: Int
    let quote, author, series: String

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author, series
    }
}
