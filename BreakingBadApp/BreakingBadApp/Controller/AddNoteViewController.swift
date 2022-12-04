//
//  AddNoteViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 28.11.2022.
//

import UIKit
import SwiftAlertView


class AddNoteViewController: UIViewController {
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var episodeTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var addNoteButton: UIButton!
    let seasonPicker = UIPickerView()
    let episodePicker = UIPickerView()
    var episodes = [EpisodesModel]()
    var filteredEpisodes = [EpisodesModel]()
    var seasons = ["Season 1","Season 2","Season 3","Season 4","Season 5"]
    var viewTitle = "Create a Note"
    var buttonTitle = "Add Note"
    var noteModel : Note?
    var status = false
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoteButton.setTitle(buttonTitle, for: .normal)
        self.title = viewTitle
        if status { //Update durumu true ise valueları doldur değil ise yeni bir note eklenecek anlamına gelir.
            episodeTextField.text = noteModel?.episode
            seasonTextField.text = noteModel?.season
            noteTextField.text = noteModel?.noteText
            episodeTextField.isEnabled = true // Update ekranında sezon seçili olduğu için aktif olmasında sakınca yok.
        } else {
            episodeTextField.isEnabled = false // Kullanıcı sezon seçmeden bölümlere erişemez.
        }
        getEpisodes()
        
        seasonPicker.delegate = self
        seasonPicker.dataSource = self
        episodePicker.delegate = self
        episodePicker.dataSource = self
        seasonTextField.inputView = seasonPicker
        episodeTextField.inputView = episodePicker
        createToolbar()
    }
    
    func getEpisodes(){
        NetworkManager.shared.getAllEpisodes(series: "Breaking+Bad") { result in
            switch result {
            case.success(let episodes):
                self.episodes = episodes
            case.failure(let error):
                print(error)
            }
        }
    }
    func createToolbar(){
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
                toolbar.setItems([doneButton], animated: false)
                    
                toolbar.isUserInteractionEnabled = true
        seasonTextField.inputAccessoryView = toolbar
        episodeTextField.inputAccessoryView = toolbar
                
            }
            
            @objc func dismissPicker() {
                view.endEditing(true)
            }
    

    @IBAction func addNote(_ sender: UIButton) {
        if seasonTextField.text != "" && episodeTextField.text != ""  {//Değerlerden biri boş ise kayıt işlemini yapamaz.
            if sender.titleLabel?.text == "Add Note" {
                CoreDataManager.shared.saveNote(seasonName: seasonTextField.text!, episodeName: episodeTextField.text!, noteText:noteTextField.text!)
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            } else {// Update note kısmı
                noteModel?.season = seasonTextField.text
                noteModel?.episode = episodeTextField.text
                noteModel?.noteText = noteTextField.text
                do {
                    try CoreDataManager.shared.managedContext.save()
                    navigationController?.popViewController(animated: true)
                    dismiss(animated: true, completion: nil)
                } catch {
                    print("error")
                }
                
            }
            
            
        } else {
            SwiftAlertView.show(title: "Error",message:"Choose a season and episode",buttonTitles: "OK") {
                $0.style = .dark
            }
        }
        
        
}
    

}
extension AddNoteViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == seasonPicker {
            return seasons.count
        } else {
            return filteredEpisodes.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == seasonPicker { //Seçilen sezona göre bölümleri filtreleyebiliriz.
            let type = SectionType(rawValue: row)
            switch type {
            case .season1:
                filteredEpisodes = episodes.filter({$0.season == "1"})
                return seasons[row]
            case .season2:
                filteredEpisodes = episodes.filter({$0.season == "2"})
                return seasons[row]
            case .season3:
                filteredEpisodes = episodes.filter({$0.season == "3"})
                return seasons[row]
            case .season4:
                filteredEpisodes = episodes.filter({$0.season == "4"})
                return seasons[row]
            case .season5:
                filteredEpisodes = episodes.filter({$0.season == "5"})
                return seasons[row]
            default:
                fatalError("Error")
            }
          
        } else {
            return filteredEpisodes[row].title
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == seasonPicker {
            seasonTextField.text = seasons[row]
            if seasonTextField.text != "" {
                episodeTextField.isEnabled = true
            }
        } else {
            episodeTextField.text = "Episode \(row+1) - \(filteredEpisodes[row].title)"
        }
    }
    
    
}


