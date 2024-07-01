//
//  NotesView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI
import RealmSwift

struct NotesView: View {
    
    // MARK: PROPERTIES
    
    @State private var columns: Int = 2
    private var columnGrid: [GridItem] {
        [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 2.5))]
    }
    @EnvironmentObject var realmManager: NoteRealManager
    @State private var isWideMode: Bool = false
    @State var openDetail: Bool = false
    @State var openNewNote: Bool = false
    @State var editNote: Bool = false
    @State var selectedNote: RealmNote?
    @State var search = ""
    @ObservedRealmObject var realmNotes: RealmNotes
    @State var half: Bool = false
    

    // MARK: BODY
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if realmNotes.notes.isEmpty {
                    noNotesView
                } else {
                    scrollNotesView
                    
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        addNoteButton
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 90)
            }
            .searchable(text: $search)
            .navigationTitle("Notes")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customWhiteColor)
        }
        .sheet(isPresented: $openNewNote) {
            AddNoteView(realmNotes: realmNotes)
                .environmentObject(realmManager)
            
        }
        .sheet(isPresented: $editNote, content: {
            AddNoteView(realmNotes: realmNotes)
                .environmentObject(realmManager)
            
        })
    }
}

extension NotesView {
    
    // MARK: SUBVIEWS
    /// Button to add new note
    @ViewBuilder
    private var addNoteButton: some View {
        Button {
            withAnimation(.snappy) {
                realmManager.selectedNote = nil
                openNewNote = true
            }
        } label: {
            Text("+")
                .padding()
                .font(.custom(FontNames.kPoppinsMedium, size: 30))
                .foregroundColor(Color.white)
                .background(Color.customOrangeColor)
                .clipShape(Circle())
            
        }
        .buttonStyle(.plain)
        .shadow(
            color: .black,
            radius: 5,
            x: 2,
            y: 2
        )
        
    }
    
    /// View to display when there is no notes in the realm db
    @ViewBuilder
    private var noNotesView: some View {
        VStack {
            Text("No hay notas")
                .font(.custom(FontNames.kPoppinsSemiBold, size: 25))
            Text("Crea la primera")
                .font(.custom(FontNames.kPoppinsRegular, size: 25))
            Image(systemName: "arrow.down.forward")
                .resizable()
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: 10))
                .padding(.top, 40)
                .scaleEffect(half ? 0.8 : 1.0)
                .animation(.easeInOut(duration: 1.0), value: half)
                .onAppear {
                    startAnimation()
                }
        }
    }
    
    /// Scroll notes view
    @ViewBuilder
    private var scrollNotesView: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: columnGrid, spacing: 20) {
                ForEach(realmNotes.notes) { note in
                    
                    if note.shouldOccupyFullWidth {
                        Section {
                            
                        } header: {
                            NoteRowView(note: note, editNote: $editNote)
                        }
                    } else {
                        NoteRowView(note: note, editNote: $editNote)
                    }
                    
                }
                
            }
            
            .padding(.horizontal, 10)
        }
        .refreshable {
            
        }
        .safeAreaInset(edge: .bottom, content: {
            Spacer()
                .frame(height: 85)
        })
        .safeAreaInset(edge: .top, content: {
            Spacer()
                .frame(height: 10)
        })
    }
}

extension NotesView {
    
    // MARK: PRIVATE FUNCS
    /// Function to animate arrow
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            half.toggle()
        }
    }
}


struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        let realm = realmWithData()
        return NotesView(realmNotes: realm.objects(RealmNotes.self).first!)
            .environment(\.realm, realm)
            .environmentObject(NoteRealManager())
    }
}
