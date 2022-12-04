//
//  NoteViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 28.11.2022.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var noteTableView: UITableView!
    var notes = [Note]()
    var selectedEpisode = ""
    var selectedSeason = ""
    var selectedNote : Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
        noteTableView.reloadData()
        
    }
    
    func fetchNotes(){
        notes = CoreDataManager.shared.getNote()
    }
    
    func configureButton(){//floating button configure
        let floatingButton = UIButton()
                floatingButton.setTitle("Add", for: .normal)
        floatingButton.backgroundColor = .systemPink
                floatingButton.layer.cornerRadius = 25
                
                view.addSubview(floatingButton)
                floatingButton.translatesAutoresizingMaskIntoConstraints = false

                floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
                floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
                floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true

                floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
               //floatingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                floatingButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
    }
    @objc func addNote(){
        
       performSegue(withIdentifier: "addNote", sender: nil)
        
    }


}

extension NotesViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].episode
        cell.detailTextLabel?.text = notes[indexPath.row].season
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = notes[indexPath.row]
            CoreDataManager().managedContext.delete(object)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
               try  CoreDataManager().managedContext.save()
            } catch {
                print("error")
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        selectedEpisode = notes[indexPath.row].episode!
        selectedSeason = notes[indexPath.row].season!
        performSegue(withIdentifier: "updateNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateNote" {
            if let updateNote = segue.destination as? AddNoteViewController {
                updateNote.viewTitle = "Update Note"
                updateNote.buttonTitle = "Update"
                updateNote.status = true
                updateNote.noteModel = selectedNote
            }
        }   else if segue.identifier == "addNote" {
            if let addNote = segue.destination as? AddNoteViewController {
                addNote.status = false
                addNote.viewTitle = "Create a Note"
                addNote.buttonTitle = "Add Note"
                
                
            }
        }
    }
    
    
}

