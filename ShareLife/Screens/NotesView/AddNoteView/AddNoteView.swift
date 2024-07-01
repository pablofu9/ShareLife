//
//  AddNoteView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import SwiftUI
import RealmSwift

struct AddNoteView: View {
    
    @State var title: String = ""
    @State var message: String = ""
    @Environment(\.dismiss) var dismiss
    @State var user: User
    @ObservedResults(RealmNote.self) var notes
    // Create a new Realm Item object.
    var note: RealmNote? 
    
    @State private var newNote = RealmNote()
    var body: some View {
        VStack {
            if let selectedNote = note {
                HStack {
                    Text(selectedNote.date)
                        .font(.custom(FontNames.kPoppinsThin, size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                   
                    deleteItemButton
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            
            
            TextField("Título", text: $title)
                .textFieldStyle(OvalTextFieldStyle())
            TextEditor(text: $message)
                .padding(.horizontal, 20)
                .scrollContentBackground(.hidden)
                .font(.custom(FontNames.kPoppinsRegular, size: 15))
                .lineSpacing(10)
                .accentColor(.black)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
          addNoteButton
            
        }
        .onAppear {
            DispatchQueue.main.async {
                if let selectedNote = note {
                    title = selectedNote.title
                    message = selectedNote.message
                }
            }
        }
        .padding(.vertical, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.customWhiteColor)
        
    }
}

extension AddNoteView {
    
    // MARK: SUBVIEWS
    /// Button to add or update note
    @ViewBuilder
    private var addNoteButton: some View {
        Button {
            addOrUpdateNote()
        } label: {
            Text("Save")
                .font(.custom(FontNames.kPoppinsMedium, size: 20))
                .padding(.horizontal, 30)
                .foregroundStyle(Color.customWhiteColor)
                .padding(.vertical, 10)
                .background(Color.customBrownColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
  
        }
        .shadow(
            color: .black.opacity(0.8),
            radius: 3,
            x: 2,
            y: 2
        )
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private var deleteItemButton: some View {
        Button {
           deleteNote()
        } label: {
            Image(systemName: "trash")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(10)
                .background(.red.opacity(0.6))
                .clipShape(Circle())
              
        }
        
        .buttonStyle(.plain)
    }
}

extension AddNoteView {
    
    // MARK: PRIVATE FUNCTIONS
    
    private func addOrUpdateNote() {
        if let selectedNote = note {
            updateNote(selectedNote: selectedNote)
        } else {
            addNewNote()
        }
        dismiss()
    }
    
    private func updateNote(selectedNote: RealmNote) {
        withAnimation(.snappy) {
                if let noteToModify = notes.first(where: { $0.id == selectedNote.id }) {
                    noteToModify.thaw()?.title = title
                    noteToModify.thaw()?.message = message
                    noteToModify.thaw()?.date = DateTimeManager.shared.getCurrentDate()
                    noteToModify.thaw()?.shouldOccupyFullWidth = message.count > 30 ? true : false
                    notes.realm?.add(noteToModify, update: .modified)
                }
                dismiss()
            }
            dismiss()
        
    }

    
    private func addNewNote() {
        withAnimation(.snappy) {
            if !title.isEmpty || !message.isEmpty {
                newNote.ownerId = user.id
                newNote.title = title
                newNote.message = message
                newNote.date = DateTimeManager.shared.getCurrentDate()
                newNote.shouldOccupyFullWidth = message.count > 30 ? true : false
                $notes.append(newNote)
            }
            dismiss()
        }
    }
    
    private func deleteNote() {
        if let selectedNote = note {
            if let noteToRemove = notes.first(where: { $0.id == selectedNote.id }) {
                $notes.remove(noteToRemove)
            }
            dismiss()
        }
    }
}



