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
            Text("Username: \(username)")
            TextField("Confirmation Code", text: $confirmationCode)
            Button("Confirm", action: {
                sessionManager.confirm(username: username, code: confirmationCode)
            })
        }
        .padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "kilo loco")
    }
}
