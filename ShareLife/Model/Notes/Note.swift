//
//  Note.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import Foundation

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
