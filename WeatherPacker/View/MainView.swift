//
//  MainView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct MainView: View {
    @State var signInSuccess = false
    @State var userId = UUID()
    @State var tripCollectionRepository = TripCollectionRepository()
    
    var body: some View {
        return Group {
            if signInSuccess {
                TrippView(userId:userId, tripCollectionRepository: tripCollectionRepository)
            } else {
                LoginView(signInSuccess: $signInSuccess,userId: $userId, tripCollectionRepository: $tripCollectionRepository)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct TrippView: View {
    var userId : UUID
    var tripCollectionRepository:TripCollectionRepository
    
  var body: some View {
    let trips = tripCollectionRepository.trips
      NavigationView {
          VStack {
            Text("Trip Data").padding(12).font(Font.headline.weight(.bold))
              Text("UserId:\(userId.uuidString)")
            ForEach(trips) { trip in
              VStack {
                Text("Id: " + trip.id.uuidString)
                Text("Location: " + trip.tripLocation)
                Text("Start: " + trip.tripStartDate)
                Text("End: " + trip.tripEndDate)
                Text("IsExpired: ")
                Text(trip.isExpired ? "true" : "false")
              }
                NavigationLink(destination:CreationLocationView(userId: userId)) {
                    Text("Create Trip")
                }
              
            }
          }
      }
  }
}

struct LoginView: View {
    
    @Binding var signInSuccess:Bool
    @Binding var userId:UUID
    @Binding var tripCollectionRepository:TripCollectionRepository
    
    @State var userName = ""
    @State var pwd = ""
    
    @ObservedObject var userRepository = UserRepository()
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    TextField("User Name", text: $userName)
                    TextField("Password", text: $pwd)
                }
                Button(action: {
                    if userRepository.verify(userName: userName, pwd: pwd) {
                        self.userId = userRepository.getUserId(userName: userName)
                        self.tripCollectionRepository.getById(userId: userId.uuidString)
                        self.signInSuccess = true
                    }
                }) {
                    Text("Login")
                }
            }
        }
    }
}
