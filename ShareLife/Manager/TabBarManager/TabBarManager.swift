//
//  TabBarManager.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation
import SwiftUI

protocol TabBarItem {
    var icon: String { get }
    var title: String { get }
}

// MARK: - Tab bar manager
final class TabBarManager<Tab: TabBarItem & CaseIterable>: ObservableObject {
    @Published var tabs = Tab.allCases
    @Published var currentTab = Tab.allCases.first
    
}
