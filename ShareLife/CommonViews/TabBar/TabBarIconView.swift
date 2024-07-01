//
//  TabBarIconView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//


import SwiftUI

// MARK: - Each icon of the tab bar
struct TabBarIconView<Tab: TabBarItem & CaseIterable>: View {
    
    // MARK: - Variables
    let tab: Tab
    let selected: Bool
    var index: Int
    
    // MARK: - Body
    var body: some View {
        CustomTabItem
    }
    
    // MARK: - Every single tab item of the tab bar
    @ViewBuilder
    private var CustomTabItem: some View {
        HStack(spacing: 10){
            Spacer()
            VStack(spacing: 10) {
                Spacer()
                Image(systemName: tab.icon)
                    .foregroundStyle(selected ? Color.customGrayColor : Color.black)
                    .scaleEffect(selected ? 1.5 : 1, anchor: .top)

                Text(tab.title)
                    .font(.custom(FontNames.kPoppinsRegular, size: 11))
                    .foregroundStyle(selected ? Color.customGrayColor : Color.black)
                    .lineLimit(1)

            }
            .opacity(selected ? 1 : 0.7)
            .padding(.bottom, 10)
            Spacer()
        }
        .background(Color.clear)
    }
}


#Preview {
    TabBarIconView(tab: MainTab.notes, selected: true, index: 0)
}



