//
//  View+Utils.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import Foundation
import SwiftUI

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color, fontName: String, fontSize: CGFloat) -> some View {
        let uiColor = UIColor(color)
        let font = UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: uiColor,
            .font: font
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: uiColor,
            .font: font
        ]
        
        return self
    }
}
