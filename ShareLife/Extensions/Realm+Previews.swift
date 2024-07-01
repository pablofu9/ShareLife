//
//  Realm+Previews.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation
import RealmSwift
import SwiftUI

extension PreviewProvider {
    
    // MARK: PREVIEW PROVIDER
    /// Function to make preview
    static func emptyRealmInMemory() -> Realm {
        var conf = Realm.Configuration.defaultConfiguration
        conf.inMemoryIdentifier = "preview"
        
        let realm = try! Realm(configuration: conf)
        return realm
    }
    
    /// Function to get preview data
    static func realmWithData(realm: Realm = emptyRealmInMemory()) -> Realm {
        let notes = realm.objects(RealmNotes.self)
        if notes.count == 0 {
            let notes = RealmNotes()
            
            for i in 0...9 {
                notes.notes.append(RealmNote(title: "Mock Title\(i)", message: "Mock message \(i)", shouldOccupyFullWidth: Bool.random(), date: "2024-06-30"))
            }
            
            try? realm.write({
                realm.add(notes)
            })
        }
        
        return realm
    }
}
