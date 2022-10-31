//
//  TripView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct UserView: View {
  @ObservedObject var userRepository = UserRepository()
  
  func add() {
    userRepository.add(User(id: UUID(), name: "newUser", pwd: "123123"))
  }
  
  func remove() {
    userRepository.remove(User(id: UUID(uuidString: "169FBF47-2827-448D-8514-8A8DB1B7E879")!, name: "newUser", pwd: "123123"))
  }
  
  func update() {
    userRepository.update(User(id: UUID(uuidString: "CA55538D-66FC-4367-A506-A1EAC9E55D1C")!, name: "newUser", pwd: "123456"))
  }
  
  var body: some View {
    
    let users = userRepository.user
    ScrollView {

      VStack {
        Text("User Data").padding(12).font(Font.headline.weight(.bold))
        ForEach(users) { user in
          Text("ID: " + user.id.uuidString).padding()
          Text("User Name: " + user.name).padding()
          Text("User Pwd: " + user.pwd).padding()
        }
        Button(action: add) {
          Text("Add user")
        }
        Button(action: remove) {
          Text("Remove user")
        }
        Button(action: update) {
          Text("Update user")
        }
      }}
  }
  
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView()
  }
}
