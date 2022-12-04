//
//  CharacterModel.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import Foundation

struct CharacterModel : Codable {
    let charID: Int
    let name, birthday: String
    let occupation: [String]
    let img: String
    let status, nickname: String
    let appearance: [Int]
    let portrayed, category: String
    

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
    }
}
