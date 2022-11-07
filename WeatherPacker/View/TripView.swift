//
//  TripView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct TripView: View {
//  @ObservedObject var tripCollectionRepository = TripCollectionRepository(userId:"A4B1A196-5E05-4A03-ADF8-7AD019C27410")
    @ObservedObject var tripCollectionRepository = TripCollectionRepository()
  
  var body: some View {
    
    let trips = tripCollectionRepository.trips
  
    VStack {
      Text("Trip Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(trips) { trip in
        VStack {
          Text("Id: " + trip.id.uuidString)
          Text("Location: " + trip.tripLocation)
          Text("Start: " + trip.tripStartDate)
          Text("End: " + trip.tripEndDate)
          Text("IsExpired: ")
          Text(trip.isExpired ? "true" : "false")
        }
      }
    }
  }
}

struct TripView_Previews: PreviewProvider {
  static var previews: some View {
    TripView()
  }
}

struct LoginningView: View {
    
    @State var userName = ""
    @State var pwd = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    TextField("User Name", text: $userName)
                    TextField("Password", text: $pwd)
                    NavigationLink(destination:TripView()){
                        Button(action:{}) {
                            Text("Login")
                        }
                    }.navigationBarHidden(true)
                }
            }
        }
    }
}
