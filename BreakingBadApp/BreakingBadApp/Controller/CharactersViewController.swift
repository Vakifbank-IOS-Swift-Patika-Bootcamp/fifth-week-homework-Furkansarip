//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit
import Kingfisher
import MaterialActivityIndicator
import SwiftAlertView

final class CharactersViewController: UIViewController {
    let indicator = MaterialActivityIndicatorView()
    
    private var characterArray = [CharacterModel]()
    //CharacterDetail sayfasına gidicek değerler için oluşturulmuş değişkenler
    var status = ""
    var nickname = ""
    var name = ""
    var birthday = ""
    var imgURL = ""
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        indicator.startAnimating()
        indicatorSetup()
        getAllCharacters()//Network işlemimiz
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
        
    }
    
    func indicatorSetup(){
        view.addSubview(indicator)
        indicator.color = .green
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    func getAllCharacters(){
        NetworkManager.shared.getAllCharacters(path: "characters") { [weak self] result in
             guard let self = self else { return }
             switch result {
             case .success(let characters):
                 self.characterArray = characters
                 DispatchQueue.main.async {
                     self.collectionView.reloadData()
                     self.indicator.stopAnimating()
                     
                 }
             case .failure(let error):
                 print(error)
             }
         }
    }

}



extension CharactersViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
        cell.characterNameLabel.text = "Name : \(characterArray[indexPath.item].name)"
        cell.birthdayLabel.text = "Birthday : \(characterArray[indexPath.item].birthday)"
        cell.nicknameLabel.text = "Nickname : \(characterArray[indexPath.item].nickname)"
        let url = URL(string: characterArray[indexPath.item].img)
        
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 341, height: 188)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        name = characterArray[indexPath.item].name
        nickname = characterArray[indexPath.item].nickname
        birthday = characterArray[indexPath.item].birthday
        status = characterArray[indexPath.item].status
        imgURL = characterArray[indexPath.item].img
        performSegue(withIdentifier: "characterDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//Detail ekranına veriler gitmeden önce ayarlamaları yapıyoruz.
        let destination = segue.destination as! CharacterDetailViewController
        destination.name = name
        destination.nickname = nickname
        destination.birthday = birthday
        destination.status = status
        destination.imgURL = imgURL
        
    }
    
    
}

