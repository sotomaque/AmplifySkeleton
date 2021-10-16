//
//  ConfirmationView.swift
//  AmplifySkeleton
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import SwiftUI


struct ConfirmationView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    let username: String

    @State private var confirmationCode = ""

    
    var body: some View {
        VStack {
            logo
            welcome
        
            confirmationForm
            .padding(.horizontal)
            
            confirm
//            startOver
//            .padding(.vertical, 4)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: COMPONENTS
    private var confirmationForm: some View {
        Group {
            TextField("Confirmation Code", text: $confirmationCode)
                .frame(height: 50)
            Divider()
           
            Spacer()
            Spacer()
        }
    }
    

}

// PREVIEW
//struct ConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//            Group {
//                ConfirmationView()
//                
//                ConfirmationView()
//                    .preferredColorScheme(.dark)
//            }
//    }
//}

extension ConfirmationView {
    // Image
    private var logo: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 80, height: 80)
            .padding(.top, 60)
        
    }
    
    // Text
    private var welcome: some View {
        VStack {
            Text("Confirm Code")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.bottom)
            
            Text("Check your Email 👀")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 60)
        }
    }
    
    // AWS Code Confirmation
    private var confirm: some View {
            Text("Confirm")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: getWidth() - 80)
                .padding()
                .background(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.vertical, 8)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        // vm.confirm
                        sessionManager.confirm(username: username, code: confirmationCode)
                    }
                }
    }
}
