//
//  CollectionViewCell.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        characterNameLabel.numberOfLines = 0
        characterNameLabel.adjustsFontSizeToFitWidth = true
        characterNameLabel.minimumScaleFactor = 0.5
        characterNameLabel.sizeToFit()
        nicknameLabel.textColor = .black
        characterNameLabel.textColor = .black
        birthdayLabel.textColor = .black
        self.layer.cornerRadius = CGFloat(20)
        self.imageView.layer.cornerRadius = CGFloat(30)
        self.imageView.layer.borderWidth = CGFloat(1)
        self.imageView.contentMode = .scaleToFill
    }

}
