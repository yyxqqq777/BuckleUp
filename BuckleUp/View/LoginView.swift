//
//  LoginView.swift
//  BuckleUp
//
//  Created by Yunxuan Yu on 12/8/22.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var signInSuccess:Bool
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var tripCollectionRepository:TripCollectionRepository
    @ObservedObject var userRepository = UserRepository()
    
    @State var userName = ""
    @State var pwd = ""
    @State var error = ""
    
    var body: some View {
        if userAuth.currentUserViewState == UserViewState.login {
            NavigationView {
                ZStack {
                    VStack {
                        Image("Login").resizable().frame(width:360 ,height:300)
                        Form{
                            TextField("User Name", text: $userName)
                                .onChange(of: userName, perform: {newValue in self.error = ""})
                            SecureField("Password", text: $pwd)
                                .onChange(of: pwd, perform: {newValue in self.error = ""})
                            Text(error)
                                .foregroundColor(.red)
                        }.scrollContentBackground(.hidden)
                        Button(action: {
                            if userRepository.verify(userName: userName, pwd: pwd) {
                                self.userAuth.userId = userRepository.getUserId(userName: userName)
                                self.tripCollectionRepository.getById(userId:userAuth.userId)
                                self.signInSuccess = true
                            } else {
                                error = "User does not exist or wrong password"
                            }
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity, maxHeight: 40)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .background(Color("PrimaryOrange"))
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        HStack {
                            Text("New to Buckle Up?")
                                .foregroundColor(.gray)
                            NavigationLink(destination: SignUpView()) {
                                Text("Create account")
                                    .foregroundColor(Color("PrimaryOrange"))
                            }
                        }
                    }.background(Color.white)
                }
            }
        } else {
            SignUpView()
        }
    }
}
