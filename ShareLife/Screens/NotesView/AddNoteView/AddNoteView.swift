//
//  AddNoteView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import SwiftUI

struct AddNoteView: View {
    
    @EnvironmentObject var realManager: NoteRealManager
    @State var title: String = ""
    @State var message: String = ""
    @Environment(\.dismiss) var dismiss

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            if realManager.selectedNote != nil {
                HStack {
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
            if let selectedNote = realManager.selectedNote {
                title = selectedNote.title
                message = selectedNote.message
            }
        }
        .padding(.vertical, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.primaryColor)
        
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
                .padding(.vertical, 10)
                .background(Color.primaryBlue)
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
            if let selectedNote = realManager.selectedNote {
                realManager.deleteNote(id: selectedNote.id)
                dismiss()
            }
        } label: {
            Image(systemName: "trash")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(10)
                .background(.red)
                .clipShape(Circle())
              
        }
        .buttonStyle(.plain)
    }
}

extension AddNoteView {
    
    // MARK: PRIVATE FUNCTIONS
    
    /// Add or update note
    private func addOrUpdateNote() {
        if let selectedNote = realManager.selectedNote {
            withAnimation(.snappy) {
                realManager.updateNotes(id: selectedNote.id, title: title, message: message)
                dismiss()
            }
        } else {
            withAnimation(.snappy) {
                if !title.isEmpty || !message.isEmpty {
                    realManager.addNote(title: title, message: message, shouldOccupyFullWidth: true, date: DateTimeManager.shared.getCurrentDate())
                }
                    dismiss()
                
            }
        }
    }
}


#Preview {
    AddNoteView()
        .environmentObject(NoteRealManager())
}
