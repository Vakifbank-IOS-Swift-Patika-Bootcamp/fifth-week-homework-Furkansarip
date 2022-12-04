//
//  CoreDataManager.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 29.11.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveNote(seasonName:String, episodeName:String, noteText:String) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(seasonName, forKey: "season")
        note.setValue(episodeName, forKey: "episode")
        note.setValue(noteText, forKey: "noteText")
        
        do {
           try managedContext.save()
            return note as? Note
        } catch {
            print("Error")
        }
        return nil
    }
   
    
    func getNote() -> [Note] {
       let fetch = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetch)
            return notes as! [Note]
        } catch {
            print("Error")
        }
        return []
    }
}
