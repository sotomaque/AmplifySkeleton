//
//  SessionManager.swift
//  AmplifySkeleton
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import Amplify
import Combine
import SwiftUI

enum AuthState {
    case signup
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}


final class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    // check if logged in or not
    // if logged in -> session
    // else login screen
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signup
    }
    
    func showLogin() {
        authState = .login
    }
    
    func login(username: String, password: String) {
        _ = Amplify.Auth.signIn(username: username, password: password) {
            result in
            
            switch result {
                case .success(let signInResult):
                    print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self.getCurrentAuthUser()
                    }
                }
                    
                case .failure(let error):
                    print("Login Error: ", error)
            }
        }
    }
    
    func signUp(username: String, email: String, password: String) {
        let attributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        _ = Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { [weak self] result in
            
            switch result {
                case .success(let signUpResult):
                    print("Sign up result: ", signUpResult)
                
                switch signUpResult.nextStep {
                    case .done:
                        print("Done Signing Up")
                        
                    case .confirmUser(let details, _):
                        // push to confirmation screen
                        print(details ?? "no details")
                        DispatchQueue.main.async {
                            self?.authState = .confirmCode(username: username)
                        }
                }
                    
                case .failure(let error):
                    print("Sign up error: ", error)
            }
            
        }
    }
    
    func confirm(username: String, code: String) {
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { [weak self] result in
            
            switch result {
                case .success(let confirmResult):
                    print(confirmResult)
                    if confirmResult.isSignupComplete {
                        DispatchQueue.main.async {
                            self?.showLogin()
                        }
                    }
                    
                case .failure(let error):
                    print("Failed to confirm code: ", error)
            }
        }
    }
}
