//
//  ClothesView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ClothesView: View {
  @ObservedObject var locationRepository = LocationRepository()
  
  var body: some View {
    
    let clothes = locationRepository.clothes
  
    VStack {
      ForEach(clothes) { cloth in
        VStack {
          Text("id: " + cloth.id.uuidString)
          Text(cloth.clothesTitle)
          Text(cloth.category)
          Text("\(Int(cloth.temperatureAdded))")
        }
      }
    }
  }
}

struct ClothesView_Previews: PreviewProvider {
  static var previews: some View {
    ClothesView()
  }
}


