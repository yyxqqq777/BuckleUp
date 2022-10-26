//
//  TripView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct UserView: View {
  @ObservedObject var locationRepository = LocationRepository()
  
  var body: some View {
    
    let users = locationRepository.user
  
    VStack {
      ForEach(users) { user in
        Text("ID: " + user.id.uuidString).padding()
        Text("User Name: " + user.name).padding()
      }
    }
  }
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView()
  }
}
