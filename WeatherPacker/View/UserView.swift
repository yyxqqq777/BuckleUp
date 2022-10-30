//
//  TripView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct UserView: View {
  @ObservedObject var userRepository = UserRepository()
  
  var body: some View {
    
    let users = userRepository.user
  
    VStack {
      Text("User Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(users) { user in
        Text("ID: " + user.id.uuidString).padding()
        Text("User Name: " + user.name).padding()
        Text("User Pwd: " + user.pwd).padding()
      }
    }
  }
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView()
  }
}
