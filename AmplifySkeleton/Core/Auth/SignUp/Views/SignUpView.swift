//
//  SignUpView.swift
//  AmplifySkeleton
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import SwiftUI

struct SignUpView: View {

    @EnvironmentObject var sessionManager: SessionManager

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Username", text: $username)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button("Sign Up", action: {
                sessionManager.signUp(username: username, email: email, password: password)
            })
            
            Spacer()
            Button("Already have an account? Log in.", action: {
                sessionManager.showLogin()
            })
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

