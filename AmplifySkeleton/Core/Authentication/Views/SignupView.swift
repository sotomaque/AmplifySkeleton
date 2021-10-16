//
//  SignupView.swift
//  CryptoTracker
//
//  Created by Enrique Sotomayor on 10/15/21.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var sessionManager: SessionManager

    @State private var name: String = "" // do something locally with it? or dont require it? or change aws config for it?
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State var termsAgreed: Bool = false

    
    var body: some View {
        VStack {
            logo
            welcome

            signupForm
            .padding(.horizontal)
            
            signUp
                .onTapGesture {
                    // vm.handleSignUp
                    sessionManager.signUp(username: username, email: email, password: password)
                }
            signIn
            .padding(.vertical, 4)
            
        }
    }
    
    // MARK: COMPONENTS
    private var signupForm: some View {
        Group {
            Spacer()
            TextField("Name", text: $name)
                .frame(height: 50)
            Divider()
            
            TextField("Email Address", text: $email)
                .frame(height: 50)
            Divider()
            
            TextField("Username", text: $username)
                .frame(height: 50)
            Divider()
            
            SecureField("Password", text: $password)
                .frame(height: 50)
            Divider()
            
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    
                    Image(systemName: termsAgreed ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.indigo)
                        .padding(.trailing, 4)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                termsAgreed.toggle()
                            }
                        }
                    Text("I agree to the ")
                    Link(destination: URL(string: "https://www.eco.com/terms-conditions")!) {
                        Text("Terms and Conditions")
                            .foregroundColor(.indigo)
                    }
                    
                    Spacer()
                }
            }
            .padding(.bottom)
        }
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
        }
    }
}

extension SignupView {
    private var logo: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 80, height: 80)
            .padding(.top, 60)
        
    }
    
    private var welcome: some View {
        Text("Create account")
            .font(.title)
            .fontWeight(.heavy)
            .padding(.bottom)
    }
    
    private var signUp: some View {
            Text("Create account")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: getWidth() - 80)
                .padding()
                .background(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.vertical, 8)
    }
    
    private var signIn: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(.gray)
            
            Button {
                sessionManager.showLogin()
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.indigo)
            }
        }
    }
}
