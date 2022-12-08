//
//  UserInfo.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

enum UserViewState {
    case login, signup
}

import Foundation
class UserAuth: ObservableObject {
    @Published var userId: UUID
    @Published var currentUserViewState: UserViewState
    
    init(){
        userId = UUID()
        currentUserViewState = UserViewState.login
    }
    
    func setUserViewState(newState: UserViewState) {
      currentUserViewState = newState
    }
    
}
