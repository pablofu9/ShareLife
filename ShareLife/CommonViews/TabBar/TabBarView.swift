//
//  TabBarView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation
import SwiftUI

typealias TabProtocol = Hashable & CaseIterable & TabBarItem

// MARK: - Full tab bar view
struct TabBarView<Tab: TabProtocol>: View where Tab.AllCases == Array<Tab> {
    
    // MARK: - Variables
    @StateObject var tabBarManager: TabBarManager<Tab>
    @Binding var tabOptionPressed: Int
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            //Color.red
            HStack(spacing: 0) {
                let enumerated = Array(zip(tabBarManager.tabs.indices, tabBarManager.tabs))
                ForEach(enumerated, id: \.1) { index, tab in
                    TabBarIconView(tab: tab, selected: tab == tabBarManager.currentTab, index: index)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                tabOptionPressed = index
                                tabBarManager.currentTab = tab
                            }
                        }
                }
            }
           
        }
        .frame(maxHeight: 60)
        .background(Color.customBrownColor)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .shadow(
            color: .black.opacity(0.8),
            radius: 5,
            x: 0,
            y: 0
        )
    }
}




