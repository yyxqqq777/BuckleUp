//
//  SignUpView.swift
//  BuckleUp
//
//  Created by Yunxuan Yu on 12/8/22.
//

import SwiftUI

struct SignUpView: View {
    @State var userName: String = ""
    @State var pwd: String = ""
    @State var cfmpwd: String = ""
    @State var nameError: String = ""
    @State var pwdError: String = ""
    @State var cfmpwdError: String = ""
    @EnvironmentObject var userAuth: UserAuth
    @ObservedObject var userRepository = UserRepository()
    @State var showingModal = false
    
    var body: some View {
        ZStack {
            VStack {
                Form{
                    TextField("User Name", text: $userName)
                        .onChange(of: userName, perform: {newValue in self.nameError = ""})
                    Text(nameError)
                        .foregroundColor(.red)
                    TextField("Password", text: $pwd)
                        .onChange(of: pwd, perform: {newValue in self.pwdError = ""})
                    Text(pwdError)
                        .foregroundColor(.red)
                    TextField("Confirm Password", text: $cfmpwd)
                        .onChange(of: cfmpwd, perform: {newValue in self.cfmpwdError = ""})
                    Text(cfmpwdError)
                        .foregroundColor(.red)
                }.scrollContentBackground(.hidden)
                Spacer()
                Button(action: {
                    if pwd.count >= 6 && userName != "" && pwd == cfmpwd {
                        let newUser = User(id: UUID(), name: userName, pwd: pwd)
                        userRepository.signUp(user: newUser)
                        self.showingModal = true
                    } else {
                        pwdError = pwd.count < 6 ? "Empty Password or too short" : ""
                        nameError = userName == "" ? "User Name can not be empty" : ""
                        cfmpwdError = cfmpwd != pwd ? "Password do not match" : ""
                    }
                }) {
                    Text("Sign Up")
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .font(.title3.bold())
                .foregroundColor(.white)
                .background(Color("PrimaryOrange"))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            if $showingModal.wrappedValue {
                ZStack {
                    Color.black.opacity(0.01)
                        .edgesIgnoringSafeArea(.vertical)
                    VStack {
                        Image("ThumbsUp").resizable().frame(width: 40, height: 40)
                        Text("Congratulations")
                            .font(.title)
                            .padding(12)
                        Text("Your account has been set up")
                            .foregroundColor(Color("SecondaryBlack"))
                        Text("Click the Back button to return to login page")
                            .foregroundColor(Color("SecondaryBlack"))
                            .bold()
                    }.frame(width: 360, height: 240)
                        .background(Color.white)
                        .cornerRadius(20).shadow(radius: 8)

                }
            }
        }
    }
}

