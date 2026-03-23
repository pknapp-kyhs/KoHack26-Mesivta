//
//  Login.swift
//  KoHack26
//
//  Created by Mendel W on 3/23/26.
//

import SwiftUI


struct Login: View {
    
    let firebase = fBaseAPI()
    
    //Basic math/manipulation on variables
    let randomMathEquation = 2+2
    
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @State private var email = ""
    
    // appropriate use of variable types (private) - we don't anything else to have access
    @State private var password = ""
    
//    firebase.readFromFB(filename: email, document: "login"){lines in
//            
//    }
    //Form Validation
    //Data Validation - email is in correct format
    //Data Validation - password is at least 6 charachters
    //Complex AND/OR conditionals
    //Use of string and substring operations
    private var validInfo: Bool {
        //switch to index in the future
        email.contains("@") && email.contains(".") && password.count >= 6
    }
    
    
    var body: some View {
        VStack{
            //Graphical Interface
            TextField("Email", text: $email)
                .padding()
            TextField("Password", text: $password)
                .padding()
            // Output on user event - error message
            if password.count < 6 && password != ""{
                Text("Password is too short, must be at least six charachters")
                    .foregroundColor(Color.red)
                    .padding()
            }
            
            
            
            Button("Account Creation"){
                
                //Sensitive info is hashed
                let pwd = hashPassword(password)
                //code handoff between multiple files in the project
                firebase.writeToFB(text: email, filename: "email", document: "login")
                firebase.writeToFB(text: pwd, filename: "password", document: "login")
                
                loggedIn = true
            }

            .padding()
            .foregroundColor(.white)
            .background(!validInfo ? Color.gray : Color.blue)
            .cornerRadius(10)
            .padding()
            
            
            //If it is not valid then the button doesn't work
            //Data Validation
            .disabled(!validInfo)
        }.padding()
    }
}

#Preview {
    Login()
}
