//
//  NoteRowView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import SwiftUI

struct NoteRowView: View {
    
    // MARK: PROPERTIES
    
    var note: RealmNote
    @EnvironmentObject var realManager: NoteRealManager
    @Binding var editNote: Bool
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            headerView
            bodyView
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(
                    Color.strongGrayColor.opacity(0.65),
                    lineWidth: 1
                )
        }
        .background(Color.customOrangeColor)
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .shadow(
            color: .black.opacity(0.8),
            radius: 2,
            x: 2,
            y: 2
        )
        .padding(.horizontal)
    
       
    }
}

extension NoteRowView {
    
    // MARK: SUBVIEWS
    /// Edit button
    @ViewBuilder
    private var editButton: some View {
        Button {
            withAnimation(.snappy) {
                realManager.selectedNote = note
                editNote = true
                
            }
        } label: {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.black.opacity(0.5))
        }
    }
    
    /// header view
    @ViewBuilder
    private var headerView: some View {
        HStack(spacing: 20) {
            Text(note.title)
                .font(.custom(FontNames.kPoppinsBold, size: 30))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            Spacer()
            editButton
                .offset(y: -10)
        }
    }
    
    /// Body view
    @ViewBuilder
    private var bodyView: some View {
        Text(note.date)
            .font(.custom(FontNames.kPoppinsThin, size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
        Text(note.message)
            .font(.custom(FontNames.kPoppinsRegular, size: 15))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {
    NoteRowView(note: RealmNote.mock.first!, editNote: .constant(false))
        .environmentObject(NoteRealManager())
}
