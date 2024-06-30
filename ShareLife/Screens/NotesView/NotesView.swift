//
//  NotesView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI

struct NotesView: View {
    
    var notes: [Note]
    @State private var columns: Int = 2
    private var columnGrid: [GridItem] {
        [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 2.5))]
    }
    
    @State private var isWideMode: Bool = false
    @State var noteOpen: Note?
    @State var openDetail: Bool = false
    var body: some View {
        
        NavigationStack {
            ZStack {
                ScrollView {
                
                    LazyVGrid(columns: columnGrid, spacing: 20) {
                        ForEach(notes) { note in
                            if note.shouldOccupyFullWidth {
                                Section {
                                    
                                } header: {
                                    openRowView(note: note)
                                }
                            } else {
                                openRowView(note: note)
                            }
                        }
                    }
                    .padding(.horizontal, 10) // Agrega un padding para mejorar la apariencia
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        addNoteButton
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primaryColor)
        }
        .overlay {
            if openDetail {
                if let selectedNote = noteOpen {
                    OpenNoteView(note: selectedNote, closeView: $openDetail)
                        .zIndex(2)
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                }
            }
            if openDetail {
                Color.secondaryColor.opacity(0.5)
                    .ignoresSafeArea()
                    .blur(radius: 20)
                    .zIndex(1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.snappy) {
                            openDetail = false
                        }
                    }
            }
        }
    }
}

extension NotesView {
    
    @ViewBuilder
    private func openRowView(note: Note) -> some View {
        Button {
            withAnimation(.snappy) {
                noteOpen = note
                openDetail = true
            }
        } label: {
            NoteRowView(note: note)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var addNoteButton: some View {
        Button {
            
        } label: {
            Text("+")
                .padding()
                .font(.custom(FontNames.kPoppinsMedium, size: 30))
                .foregroundColor(Color.white)
                .background(Color.tertiaryColor)
                .clipShape(Circle())
            
            
        }
        .buttonStyle(.plain)
        .shadow(
            color: .white,
            radius: 5,
            x: 2,
            y: 2
        )

    }
}

#Preview {
    NotesView(notes: Note.mock)
}
