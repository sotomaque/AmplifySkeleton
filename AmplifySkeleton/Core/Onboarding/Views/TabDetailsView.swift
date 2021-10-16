//
//  TabDetailsView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 10/6/21.
//

import SwiftUI

struct TabDetailsView: View {
    
    @Binding var selection: Int
    @State var index: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        GeometryReader { geometry in
            VStack {
                topContent(geometry: geometry)
                bottomContent(geometry: geometry)
            }
        }
    }
}

struct TabDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                BackgroundView(selection: Binding.constant(0))
                TabDetailsView(selection: Binding.constant(0), index: 0)
            }
            
            ZStack {
                BackgroundView(selection: Binding.constant(0))
                TabDetailsView(selection: Binding.constant(0), index: 0)
            }
            .preferredColorScheme(.dark)
        }
     
    }
}

// MARK: COMPONENTS
extension TabDetailsView {
    func topContent(geometry: GeometryProxy) -> some View {
        Text(slides[index].headline)
            .font(.system(size: 60, weight: .light, design: .default))
            .fontWeight(.heavy)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .rotationEffect(Angle(degrees: index % 2 == 0 ? 270 : 90))
            .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
            .offset(x: index % 2 == 0 ? -geometry.size.width / 2.5 :  geometry.size.width / 2.5)
    }
    
    func bottomContent(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            MainText
            DescriptionText
                .padding(.horizontal)
            Spacer()
            NextButton
            LoginLink
        }
        .padding(.horizontal)
        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
    }
    
    var MainText: some View {
        Text(slides[index].title)
            .font(.system(size: 28, weight: .light, design: .monospaced))
            .foregroundColor(colorScheme == .dark ? .secondary : .primary)
            .padding(.vertical, 8)
            .multilineTextAlignment(.center)
    }
    
    var DescriptionText: some View {
        Text(slides[index].description)
            .font(.system(size: 18, weight: .light, design: .monospaced))
            .lineSpacing(5)
            .foregroundColor(colorScheme == .dark ? .secondary : .primary)
            .multilineTextAlignment(.center)
    }
    
    var NextButton: some View {
        Text(index == slides.count - 1 ? "Let's Get Started" : "Next")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: 200)
            .padding()
            .background(.indigo)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.vertical, 8)
            .onTapGesture {
                withAnimation {
                    if selection == slides.count - 1 {
                        sessionManager.showSignUp()
                    } else {
                       selection += 1
                    }
                }
            }
    }
    
    var LoginLink: some View {
        HStack {
            Text("Have an account?")
                .font(.title3)
                .fontWeight(.light)
            
            Button {
                sessionManager.showLogin()
            } label: {
                Text("Login")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.indigo)
            }

        }
    }

}
