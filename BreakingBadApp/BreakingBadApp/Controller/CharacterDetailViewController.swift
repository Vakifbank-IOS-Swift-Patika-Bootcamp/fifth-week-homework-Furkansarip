//
//  CharacterDetailViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 23.11.2022.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {

    var status = ""
    var nickname = ""
    var name = ""
    var birthday = ""
    var imgURL = ""
    var characterDetailArray = [CharacterModel]()
    var quoteArray = [QuoteModel]()
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var nicknameLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var birthdayLabel :UILabel!
    @IBOutlet weak var imageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = nickname
        nameLabel.text = "Name : \(name)"
        nicknameLabel.text = "Nickname : \(nickname)"
        birthdayLabel.text = "Birthday : \(birthday)"
        statusLabel.text = "Status : \(status)"
        let url = URL(string: imgURL)
        imageView.kf.setImage(with: url)
        
    }
    

    @IBAction func getQuote(){
        performSegue(withIdentifier: "getQuote", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! QuoteViewController
        destination.name = name
    }

}
