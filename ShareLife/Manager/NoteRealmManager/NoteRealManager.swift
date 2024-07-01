//
//  NoteRealManager.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import Foundation
import RealmSwift

class NoteRealManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published private(set) var notes: [RealmNote] = []
    @Published var selectedNote: RealmNote?
    
    init() {
        openRealm()
        getNotes()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                }
            })
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening realm", error)
        }
    }
    
    func addNote(title: String, message: String, shouldOccupyFullWidth: Bool, date: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                        localRealm.create(RealmNote.self, value: ["title": title, "message": message, "shouldOccupyFullWidth": message.count > 30 ? true : false, "date": date])
                    
                        self.getNotes()
                        print("Added new note")
                    }
                
            } catch {
                print("Error adding note to real", error)
            }
        }
    }
    
    func getNotes(orderBy: String = "date", ascending: Bool = true) {
        if let localRealm {
            self.notes = []
            self.notes = localRealm.objects(RealmNote.self)
                                   .sorted(byKeyPath: orderBy, ascending: ascending)
                                   .filter { !$0.isInvalidated }
        }
    }

    
    func updateNotes(id: ObjectId, title: String, message: String) {
            
            if let localRealm = self.localRealm {
                do {
                    let selectedNote = localRealm.objects(RealmNote.self).filter(NSPredicate(format: "id == %@", id))
                    guard !selectedNote.isEmpty else { return }
                    
                    try localRealm.write({
                            
                            selectedNote[0].title = title
                            selectedNote[0].message = message
                            selectedNote[0].date = DateTimeManager.shared.getCurrentDate()
                            selectedNote[0].shouldOccupyFullWidth = message.count > 30 ? true : false
                            self.getNotes()
                            print("Updated tasks")
                        
                    })
                } catch {
                    print("Error updating ", error)
                }
            }
        
    }
    
    func deleteNote(id: ObjectId) {
        if let localRealm = self.localRealm {
            do {
                let selectedNoteDelete = localRealm.objects(RealmNote.self).filter(NSPredicate(format: "id == %@", id))
                guard let noteToDelete = selectedNoteDelete.first else { return }
                
                try localRealm.write {
                    
                    localRealm.delete(noteToDelete)
                    //localRealm.resolve(ThreadSafeReference(to: noteToDelete))
                    //self.getNotes()
                    print("Deleted note")
                }
            } catch {
                print("Error deleting", error)
            }
        }
        
    }
}
