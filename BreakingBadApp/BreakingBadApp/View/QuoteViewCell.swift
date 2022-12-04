//
//  QuoteViewCell.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 23.11.2022.
//

import UIKit

class QuoteViewCell: UICollectionViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        quoteLabel.textColor = .white
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.minimumScaleFactor = 0.5
       
    }

}
