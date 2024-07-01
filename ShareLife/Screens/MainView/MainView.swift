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
    @StateObject var realmManager = NoteRealManager()

    @ObservedRealmObject var notes = RealmNotes()
    @ObservedResults(RealmNotes.self) var allNotesGroup
    @StateObject var mainTabBarManager = TabBarManager<MainTab>()

    var body: some View {
        content
            .onAppear {
                if allNotesGroup.first == nil {
                    $allNotesGroup.append(RealmNotes())
                }
            }
                   
       
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
            if let notes = allNotesGroup.first {
                
                NotesView(realmNotes: notes)
                    .environmentObject(realmManager)
                
            }
        case 1:
            EmptyView()
        case 2:
            EmptyView()
        default:
            EmptyView()
        }
    }
}




#Preview {
    MainView()
}
