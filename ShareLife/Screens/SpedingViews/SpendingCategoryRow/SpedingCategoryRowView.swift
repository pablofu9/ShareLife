//
//  SpedingCategoryRowView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 3/7/24.
//

import SwiftUI

struct SpedingCategoryRowView: View {
    
    let spending: RealmSpending
    let spendingType: SpendingType = .freeTime
    
    var body: some View {
        HStack {
            Image(systemName: spendingType.image)
                .padding(15)
                .background(spendingType.color)
                .clipShape(Circle())
            VStack {
                Text(spendingType.rawValue)
            }
               
        }
    }
}

#Preview {
    SpedingCategoryRowView(spending: RealmSpending.mock.first!)
}
