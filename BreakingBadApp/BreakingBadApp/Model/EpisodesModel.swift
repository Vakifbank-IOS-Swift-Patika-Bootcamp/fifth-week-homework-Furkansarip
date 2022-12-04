//
//  EpisodesModel.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 26.11.2022.
//

import Foundation


struct EpisodesModel: Codable {
    let episodeID: Int
    let title, season, airDate: String
    let characters: [String]
    let episode: String
    let series: String

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode, series
    }
}
