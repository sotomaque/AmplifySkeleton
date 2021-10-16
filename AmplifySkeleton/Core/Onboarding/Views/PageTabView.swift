//
//  PageTabView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 10/6/21.
//

import SwiftUI

struct PageTabView: View {
    @Binding var selection: Int

    var body: some View {
        TabView(selection: $selection) {
            ForEach(slides.indices, id: \.self) { index in
                TabDetailsView(selection: $selection, index: index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

// PREVIEW
struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            ZStack {
                BackgroundView(selection: Binding.constant(1))
                PageTabView(selection: Binding.constant(1))
            }

            ZStack {
                BackgroundView(selection: Binding.constant(1))
                PageTabView(selection: Binding.constant(1))

            }.preferredColorScheme(.dark)
        }

    }
}

