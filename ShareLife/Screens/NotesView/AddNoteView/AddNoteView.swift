//
//  AddNoteView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import SwiftUI
import RealmSwift
struct AddNoteView: View {
    
    @EnvironmentObject var realManager: NoteRealManager
    @State var title: String = ""
    @State var message: String = ""
    @Environment(\.dismiss) var dismiss

    @ObservedRealmObject var realmNotes: RealmNotes

    var body: some View {
        VStack {
            if let selectedNote = realManager.selectedNote {
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
            if let selectedNote = realManager.selectedNote {
                title = selectedNote.title
                message = selectedNote.message
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
        if let selectedNote = realManager.selectedNote {
            updateNote(selectedNote: selectedNote)
        } else {
            addNewNote()
        }
    }
    
    private func updateNote(selectedNote: RealmNote) {
        withAnimation(.snappy) {
            if let index = $realmNotes.notes.firstIndex(where: { $0.id == selectedNote.id }) {
                try! realManager.localRealm?.write({
                    realmNotes.notes[index].thaw()?.title = title
                    realmNotes.notes[index].thaw()?.message = message
                    realmNotes.notes[index].thaw()?.date = DateTimeManager.shared.getCurrentDate()
                    realmNotes.notes[index].thaw()?.shouldOccupyFullWidth = message.count > 30 ? true : false
                })
            }
                dismiss()
            }
    }
    
    private func addNewNote() {
        withAnimation(.snappy) {
            if !title.isEmpty || !message.isEmpty {
                $realmNotes.notes.append(RealmNote(title: title, message: message, shouldOccupyFullWidth: message.count > 30 ? true : false, date: DateTimeManager.shared.getCurrentDate()))
                
            }
            dismiss()
        }
    }
    
    private func deleteNote() {
        if let selectedNote = realManager.selectedNote {
            if let index = $realmNotes.notes.firstIndex(where: { $0.id == selectedNote.id }) {
                $realmNotes.notes.remove(at: index)
            }
            
            dismiss()
        }
    }
}


struct AddNoteView_Preview: PreviewProvider {
    static var previews: some View {
        let realm = realmWithData()
        return AddNoteView(realmNotes: realm.objects(RealmNotes.self).first!)
            .environment(\.realm, realm)
            .environmentObject(NoteRealManager())
    }
}

