//
//  TabItems.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation

enum MainTab {
    case notes
    case spendings
    case shopping
}

// MARK: - CaseIterable
extension MainTab: CaseIterable { }

// MARK: - TabBarItem
extension MainTab: TabBarItem {
    
    /// Image name for icons in tab bar
    var icon: String {
        switch self {
            
        case .notes:
            return "note.text"
        case .spendings:
            return "creditcard"
        case .shopping:
            return "cart"
        }
    }
    
    var title: String {
        switch self {
        case .notes:
            return "Notes"
        case .spendings:
            return "Spendings"
        case .shopping:
            return "Shopping"
        }
    }
    
}
