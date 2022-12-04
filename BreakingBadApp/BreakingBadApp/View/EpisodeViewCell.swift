//
//  EpisodeViewCell.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 26.11.2022.
//

import UIKit

class EpisodeViewCell: UITableViewCell {

    
    @IBOutlet weak var episodeDateLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    func configure(to episode: EpisodesModel) {
        episodeDateLabel.text = episode.airDate
        episodeNameLabel.text = episode.title
        
    }
    
    
}
