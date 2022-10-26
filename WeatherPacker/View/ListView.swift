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
          Text(list.id.uuidString)
          Text(list.listCategory)
          Text(list.date)
          Text(list.tripId)
          Text("\(Int(list.highTemp))")
          Text("\(Int(list.lowTemp))")
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

