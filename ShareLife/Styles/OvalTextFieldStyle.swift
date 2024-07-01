//
//  OvalTextFieldStyle.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 30/6/24.
//

import Foundation
import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(spacing: 0) {
            configuration
                .font(.custom(FontNames.kPoppinsBold, size: 25))
                .padding(5)
                .foregroundColor(.black)
                .background(Color.clear)
                .accentColor(.black)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black.opacity(0.4))
        }
        .padding(.horizontal, 20)
        .shadow(color: .gray, radius: 10)
    }
}


