//
//  OpenNoteView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 2/7/24.
//

import SwiftUI
import RealmSwift

struct OpenNoteView: View {
    
    @ObservedRealmObject var note: RealmNote
    
    @ObservedResults(RealmNote.self) var notes
    @State var offset: CGFloat = 0
    @State var degrees: Double = 0
    @Binding var openView: Bool
    
    // MARK: BODY
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.customWhiteColor
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .blur(radius: 10)
                    .frame(maxHeight: .infinity)
               cardView(reader: reader)
            
            }
            .onDisappear {
                $note.date.wrappedValue = DateTimeManager.shared.getCurrentDate()
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}

extension OpenNoteView {
    
    // MARK: SUBVIEWS
    
    /// Delete button
    @ViewBuilder
    private var deleteItemButton: some View {
        Button {
            withAnimation(.snappy) {
                deleteNote()
                openView = false
            }
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
    
    @ViewBuilder
    private var saveButton: some View {
        Button {
            withAnimation(.snappy) {
                openView = false
            }
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
    private func cardView(reader: GeometryProxy) -> some View {
        VStack {
            HStack {
                Text(note.date)
                    .font(.custom(FontNames.kPoppinsThin, size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                deleteItemButton
            }
            .padding(.horizontal, 20)
            TextField("Título", text: $note.title)
                .textFieldStyle(OvalTextFieldStyle())
            
            TextEditor(text: $note.message)
                .frame(height: reader.size.height / 2)
                .padding(.horizontal, 20)
                .scrollContentBackground(.hidden)
                .font(.custom(FontNames.kPoppinsRegular, size: 15))
                .lineSpacing(10)
                .accentColor(.black)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
            saveButton
        }
        .padding()
        .background(Color.customOrangeColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .shadow(
            color: .black.opacity(0.5),
            radius: 2,
            x: 2,
            y: -2
        )
        .offset(x: offset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: offset)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    onDragChanged(value)
                })
                .onEnded({ value in
                    onDragEnded(value)
                })
        )
    }
}

extension OpenNoteView {
    
    // MARK: PRIVATE FUNCS
    
    /// Delete note
    private func deleteNote() {
        if let noteToRemove = notes.first(where: { $0.id == note.id }) {
            $notes.remove(noteToRemove)
        }
        
    }
}

extension OpenNoteView {
    
    // MARK: DRAG GESTURE
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) < abs(screenCutoff) {
            offset = 0
            degrees = 0
        } else {
            withAnimation(.snappy) {
                openView = false
            }
        }
    }
    
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        if value.translation.width < 0 {
            offset = value.translation.width
            degrees = Double(value.translation.width / 25)
        }
    }
}

extension OpenNoteView {
    var screenCutoff: CGFloat {
        (UIScreen.main.bounds.width / 2)
    }
    
    var cardWitdh: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
}

#Preview {
    OpenNoteView(note: RealmNote.mock.first!, openView: .constant(false))
}
