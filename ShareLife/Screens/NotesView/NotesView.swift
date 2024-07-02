//
//  NotesView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI
import RealmSwift
import Realm

enum Sort {
    case date, alph
}

struct NotesView: View {
    
    // MARK: PROPERTIES
    
    @State private var columns: Int = 2
    
    private var columnGrid: [GridItem] {
        [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 2.5))]
    }
    @State private var isWideMode: Bool = false
    @State var openDetail: Bool = false
    @State var openNewNote: Bool = false
    @State var editNote: Bool = false
    @State var selectedNote: RealmNote?
    @State var search = ""
    @State var half: Bool = false
    @ObservedResults(RealmNote.self, sortDescriptor: SortDescriptor(keyPath: "_id", ascending: true)) var notes
    @State var user: User
    @State private var sort: Sort = .date

    
    private var sortedFilteredNotes: [RealmNote] {
        let filtered = search.isEmpty ? notes : notes.filter("title CONTAINS[c] %@ OR message CONTAINS[c] %@", search, search)
        if sort == .date {
            return filtered.sorted { note1, note2 in
                guard let date1 = DateTimeManager.shared.formatToDate(date: note1.date), let date2 =  DateTimeManager.shared.formatToDate(date: note2.date) else {
                    return false
                }
                return date1 > date2
            }
        } else {
            return filtered.sorted { note1, note2 in
                // Order alphabetically by title
                return note1.title < note2.title
            }        }
        
    }


    // MARK: BODY
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if notes.isEmpty {
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        
                        Section() {
                            Text("Sort")
                            Picker(selection: $sort) {
                                Label("Date", systemImage: "calendar").tag(Sort.date)
                                Label("Alphabetic", systemImage: "character").tag(Sort.alph)
                            } label: {
                                Text("Sort by")
                            }
                        }
                    } label: {
                        HStack {
                            Text("Sort by")
                                .font(.custom(FontNames.kPoppinsRegular, size: 18))
                                .foregroundStyle(.black)
                            Image(systemName: "ellipsis")
                                .symbolVariant(.circle)
                                .font(.title2)
                        }
                    }
                    .accentColor(.black)
                }
            }
            .searchable(text: $search)
            .navigationTitle("Notes")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customWhiteColor)
            
        }
        .overlay {
            if let selectedNote = selectedNote, editNote {
                OpenNoteView(note: selectedNote, openView: $editNote)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .scaleEffect(editNote ? 1 : 0.5, anchor: .center)
                    .animation(.easeInOut(duration: 0.5), value: editNote)


            }
        }
        .sheet(isPresented: $openNewNote) {
            AddNoteView(user: user)
            
        }
    }
}

extension NotesView {
    
    // MARK: SUBVIEWS
    /// Button to add new note
    @ViewBuilder
    private var addNoteButton: some View {
        Button {
            withAnimation(.snappy) {
              
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
                ForEach(sortedFilteredNotes, id: \.self) { note in
                    
                    if note.shouldOccupyFullWidth {
                        Section {
                            
                        } header: {
                            NoteRowView(note: note)
                               
                        }
                        .onTapGesture {
                            DispatchQueue.main.async {
                                withAnimation(.snappy) {
                                    editNote = true
                                    selectedNote = note
                                }
                            }
                        }
                    } else {
                        NoteRowView(note: note)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    withAnimation(.snappy) {
                                        editNote = true
                                        selectedNote = note
                                    }
                                }
                            }
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


