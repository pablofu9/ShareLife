//
//  LoadingView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 3/7/24.
//

import SwiftUI
import Lottie

struct LoadingView: View {
    
    // MARK : BODY
    
    var body: some View {
        ZStack {
            Color.customOrangeColor.opacity(0.5)
                .ignoresSafeArea()
                .blur(radius: 20)
            loadingLottie
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

extension LoadingView {
    
    // MARK: SUBVIEWS
    @ViewBuilder
    private var loadingLottie: some View {
        LottieView(animation: .named("loading"))
            .resizable()
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
