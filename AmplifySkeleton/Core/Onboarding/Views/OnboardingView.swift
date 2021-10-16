//
//  OnboardingView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 10/6/21.
//

import SwiftUI

let slides = [
    Slide(headline: "Welcome", title: "Track your portfolio", description: "Stay up to date with your current portfolio value without the need to check multiple apps"),
    Slide(headline: "Practice", title: "Paper Trade", description: "Simulate the real thing by trading with a fake balance, letting you refine your trading strategy"),
    Slide(headline: "Compete", title: "Join CryptoFantasy Games", description: "Paper trade for some token!")
]

struct Slide {
    let headline: String
    let title: String
    let description: String
}


struct OnboardingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            BackgroundView(selection: $selection)
            VStack {
                PageTabView(selection: $selection)
            }
        }
        .transition(.move(edge: .bottom))
    }

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                OnboardingView()
            }
        
            NavigationView {
                OnboardingView()
                    .preferredColorScheme(.dark)
            }
         
        }
       
    }
}
