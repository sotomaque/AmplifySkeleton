//
//  BackgroundView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 10/6/21.
//

import SwiftUI

struct BackgroundView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var selection: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        // Indigo top section
                        Color(UIColor.systemIndigo)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                            .cornerRadius(60, corners: [.bottomRight])
                    }
                    .background(colorScheme == .light ? .white : .black)
                   
                    // bottom section
                    // pagination
                    Color(colorScheme == .light ? .white : .black)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                        .cornerRadius(60, corners: [.topLeft])
                }
            }
            .background(Color(UIColor.systemIndigo))
        }
        .ignoresSafeArea()
        
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackgroundView(selection: Binding.constant(1))
            
            BackgroundView(selection: Binding.constant(1))
                .preferredColorScheme(.dark)
        }
    }
}
