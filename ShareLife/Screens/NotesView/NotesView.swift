//
//  NotesView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI

struct NotesView: View {
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondaryColor)
            .navigationTitle("NOTES")
            .navigationBarTitleTextColor(.black.opacity(0.8), fontName: FontNames.kPoppinsSemiBold, fontSize: 35)
        }
    }
}

#Preview {
    NotesView()
}
