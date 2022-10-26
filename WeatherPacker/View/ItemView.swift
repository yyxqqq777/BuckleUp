//
//  ItemView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ItemView: View {
  @ObservedObject var locationRepository = LocationRepository()
  
  var body: some View {
    
    let items = locationRepository.items
  
    VStack {
      ForEach(items) { item in
        VStack {
          Text("ID: " + item.id.uuidString)
          Text(item.category)
          Text(item.isChecked ? "true" : "false")
        }
      }
    }
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    ItemView()
  }
}


