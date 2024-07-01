//
//  NoteRealManager.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import Foundation
import RealmSwift
import SwiftUI


class NoteRealManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published var selectedNote: RealmNote?
    @ObservedRealmObject var realmNotes = RealmNotes()
    @ObservedResults(RealmNotes.self) var allNotesGroup
    @Published var loading: Bool = false
    
    init() {
        openRealm()
    }

    func openRealm() {
            do {
                let config = Realm.Configuration(schemaVersion: 3, migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 3 {
                        // Ejemplo de migración:
                        // Si el esquema anterior tenía una propiedad llamada `oldProperty` que ahora ha sido eliminada, puedes omitirla.
                        // migration.renameProperty(onType: RealmNote.className(), from: "oldProperty", to: "newProperty")
                    }
                })
                Realm.Configuration.defaultConfiguration = config
                localRealm = try Realm()
            } catch {
                print("Error opening realm", error)
            }
        }
    

}
