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
        Text(trip.tripName)
      }
    }
  }
}

struct TripView_Previews: PreviewProvider {
  static var previews: some View {
    TripView()
  }
}
