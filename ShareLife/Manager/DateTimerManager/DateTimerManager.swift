//
//  DateTimerManager.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation

class DateTimeManager {
    static let shared = DateTimeManager()
    
    private init() {}
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Madrid") // Ajusta la zona horaria
        return dateFormatter.string(from: Date())
    }
    
    func formatToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Madrid")
        
        let result = dateFormatter.date(from: date)
        return result
    }
    
    func isToday(dateString: String) -> Bool {
        guard let date = formatToDate(date: dateString) else { return false }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Obtén los componentes de año, mes y día de ambas fechas
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        // Compara los componentes
        return dateComponents.year == currentDateComponents.year &&
               dateComponents.month == currentDateComponents.month &&
               dateComponents.day == currentDateComponents.day
    }
    
    func formatDateStringNoSecs(_ dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm:ss"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
