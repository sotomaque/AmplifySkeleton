//
//  LoginView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 9/28/21.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager

    @State private var email: String = ""
    @State private var password: String = ""
        
    
    var body: some View {
        VStack {
            logo
            welcome
        
            loginForm
            .padding(.horizontal)
            
            signIn
            signUp
            .padding(.vertical, 4)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: COMPONENTS
    private var loginForm: some View {
        Group {
            ZStack(alignment: .trailing) {
                TextField("Email Address", text: $email)
                    .frame(height: 50)
                if (getBiometricsStatus()) {
                    Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                        .font(.title)
                        .foregroundColor(.indigo)
                        .padding()
                }
            }
            Divider()
            ZStack(alignment: .trailing) {
                TextField("Password", text: $email)
                    .frame(height: 50)
                
                Text("Forgot Password?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.indigo)
            }
            Divider()
           
            Spacer()
            Spacer()
        }
    }
    
    // MARK: FUNCTIONS
    func getBiometricsStatus() -> Bool {
        let scanner = LAContext()
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    func authenticateUser() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock ") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            // set loggedIn to true
            withAnimation(.easeOut){
//                loggedIn = true
//                call vm / session manager login
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
                LoginView()
                
                LoginView()
                    .preferredColorScheme(.dark)
            }
    }
}

extension LoginView {
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
            Text("Login")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.bottom)
            
            Text("Welcome Back")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 60)
        }
    }
    
    // Auht0 Login
    private var signIn: some View {
            Text("Sign In")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: getWidth() - 80)
                .padding()
                .background(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.vertical, 8)
                .onTapGesture {
                    withAnimation(.easeInOut) {
//                        vm.handleLogin()
                        print("hi")
                    }
                }
    }
    
    // Navigate to SignupView
    private var signUp: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundColor(.gray)
            Button {
                sessionManager.showSignUp()
            } label: {
                Text("Create Account")
                    .fontWeight(.semibold)
                    .foregroundColor(.indigo)
            }
        }
    }
}
