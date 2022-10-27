//
//  TripView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct TripView: View {
  @ObservedObject var locationRepository = LocationRepository()
  
  var body: some View {
    
    let trips = locationRepository.trips
  
    VStack {
      Text("Trip Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(trips) { trip in
        VStack {
          Text("Id: " + trip.id.uuidString)
          Text("Location: " + trip.tripLocation)
          Text("Start: " + trip.tripStartDate)
          Text("End: " + trip.tripEndDate)
          Text("User ID: " + trip.userId)
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
