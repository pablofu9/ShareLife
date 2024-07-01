//
//  MainView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    @State var tabOptionPressed: Int = 0
    @StateObject var mainTabBarManager = TabBarManager<MainTab>()
    @ObservedResults(RealmNote.self) var rNotes
    @EnvironmentObject var errorHandler: ErrorHandler
    @State var user: User

    var body: some View {
        content
                   
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack(alignment: .bottom) {
            getView(tab: tabOptionPressed)
                .frame(maxHeight: .infinity)
            Spacer()
            TabBarView(tabBarManager: mainTabBarManager, tabOptionPressed: $tabOptionPressed)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    @ViewBuilder
    private func getView(tab: Int) -> some View {
        switch tab {
        case 0:
            NotesView(user: user)
        case 1:
            EmptyView()
        case 2:
            EmptyView()
        default:
            EmptyView()
        }
    }
}




