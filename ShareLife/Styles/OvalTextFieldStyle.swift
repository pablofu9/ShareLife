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


struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(spacing: 0) {
            configuration
                .font(.custom(FontNames.kPoppinsRegular, size: 18))
                .padding(5)
                .foregroundColor(.black)
                .background(Color.clear)
                .accentColor(.black)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
        .background {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .strokeBorder(
                    Color.customOrangeColor.opacity(0.65),
                    lineWidth: 1
                )
        }
        .background(Color.clear)
        .shadow(
            color: .black.opacity(0.4),
            radius: 2,
            x: 2,
            y: 2
        )
        .padding(.horizontal, 20)
    }
}


