//
//  MainView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI


struct MainView: View {
    
    @State var selectedTab = 0
    

    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                NotesView(notes: Note.mock)
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("Notes")
                        
                    }
                    .tag(0)
                  
                
                
                Text("Second Tab")
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Second")
                    }
                    .tag(1)
                
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                           
                    }
                   
                    .tag(2)
                  
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.tertiaryColor, for: .tabBar)
        }
        .accentColor(.white)
        .shadow(color: .black, radius: 20)
    }
}


#Preview {
    MainView()
}
