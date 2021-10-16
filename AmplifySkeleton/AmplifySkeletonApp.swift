//
//  AmplifySkeletonApp.swift
//  AmplifySkeleton
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import SwiftUI

import Amplify
import AWSCognitoAuthPlugin

@main
struct AmplifySkeletonApp: App {
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
                case .login:
                    LoginView()
                    .environmentObject(sessionManager)
                    
                case.signup:
                    SignUpView()
                    .environmentObject(sessionManager)

                    
                case.confirmCode(let username):
                    ConfirmationView(username: username)
                    .environmentObject(sessionManager)

                    
                case.session(let user):
                    SessionView(user: user)
                    .environmentObject(sessionManager)

            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured successfully")
        } catch {
            print("Could not initialize Amplify", error)
        }
    }
}
