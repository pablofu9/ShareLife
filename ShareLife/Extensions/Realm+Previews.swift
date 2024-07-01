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
        let notes = realm.objects(RealmNote.self)
        if notes.count == 0 {
            var notes = RealmNote()
            
            notes = RealmNote(title: "Mock Title\(1)", message: "Mock message \(1)", shouldOccupyFullWidth: Bool.random(), date: "2024-06-30")
            try? realm.write({
                realm.add(notes)
            })
        }
        
        return realm
    }
}
