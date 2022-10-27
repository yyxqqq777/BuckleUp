//
//  ListView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ListView: View {
  @ObservedObject var locationRepository = LocationRepository()
  
  var body: some View {
    
    let lists = locationRepository.lists
  
    VStack {
      ForEach(lists) { list in
        VStack {
          Text("Id: " + list.id.uuidString)
          Text("Category: " + list.listCategory)
          Text("Date: " + list.date)
          Text("Trip Id: " + list.tripId)
          Text("High temp: \(Int(list.highTemp))°C")
          Text("Low temp: \(Int(list.lowTemp))°C")
        }
      }
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView()
  }
}

