//
//  Note.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import Foundation
import RealmSwift

struct Note: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    var shouldOccupyFullWidth: Bool
    var date: String
}

extension Note {
    static var mock: [Note] {
        [
            Note(title: "Nota 1", message: "Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1  Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1 Mensaje nota 1", shouldOccupyFullWidth: true, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: true, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020"),
            Note(title: "Nota 1", message: "Mensaje nota 1", shouldOccupyFullWidth: false, date: "20-10-2020")
        ]
    }
}

class RealmNote: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var message: String = ""
    @Persisted var shouldOccupyFullWidth: Bool = false
    @Persisted var date: String = ""
    
    @Persisted(originProperty: "notes") var group: LinkingObjects<RealmNotes>
    
    convenience init(title: String = "", message: String = "", shouldOccupyFullWidth: Bool = false, date: String = "") {
        self.init()
        self.title = title
        self.message = message
        self.shouldOccupyFullWidth = shouldOccupyFullWidth
        self.date = date
    }
    
}

class RealmNotes: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var notes = RealmSwift.List<RealmNote>()
}

extension RealmNote {
    static var mock: [RealmNote] {
        return [
            RealmNote(value: ["title": "Mock Title 1", "message": "Mock message 1", "shouldOccupyFullWidth": false, "date": "2024-06-30"]),
            RealmNote(value: ["title": "Mock Title 2", "message": "Mock message 2", "shouldOccupyFullWidth": false, "date": "2024-07-01"]),
            RealmNote(value: ["title": "Mock Title 3", "message": "Mock message 3", "shouldOccupyFullWidth": true, "date": "2024-07-02"])
        ]
    }
}
