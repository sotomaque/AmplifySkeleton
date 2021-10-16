//
//  LogInView.swift
//  AmplifySkeleton
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Login", action: {
                sessionManager.login(username: username, password: password)
            })
            
            Spacer()
            Button("Don't have an account? Sign up.", action: {
                sessionManager.showSignUp()
            })
        }
        .padding()
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
