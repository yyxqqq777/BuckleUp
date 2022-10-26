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
      ForEach(trips) { trip in
        VStack {
          Text(trip.id.uuidString)
          Text(trip.tripName)
          Text(trip.tripLocation)
          Text(trip.tripStartDate)
          Text(trip.tripEndDate)
          Text(trip.userId)
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
