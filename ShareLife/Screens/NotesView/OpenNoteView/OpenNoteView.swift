//
//  OpenNoteView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import SwiftUI

struct OpenNoteView: View {
    
    var note: RealmNote
    @Binding var closeView: Bool
    
    var body: some View {
        ZStack {


            VStack {
                Text(note.date)
                    .font(.custom(FontNames.kPoppinsThin, size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(note.title)
                    .font(.custom(FontNames.kPoppinsBold, size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(note.message)
                    .font(.custom(FontNames.kPoppinsRegular, size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(
                        Color.tertiary.opacity(0.65),
                        lineWidth: 1
                    )
            }
            .background(Color.secondaryColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
            .shadow(
                color: .black.opacity(0.5),
                radius: 2,
                x: 2,
                y: 2
            )
            .padding(.horizontal)
        }
       
        .frame(maxWidth: .infinity, maxHeight: .infinity)
       
    }
}

#Preview {
    OpenNoteView(note: RealmNote.mock.first!, closeView: .constant(false))
}
