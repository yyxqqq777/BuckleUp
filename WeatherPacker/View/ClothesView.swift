//
//  ClothesView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ClothesView: View {
  @ObservedObject var clothesRepository = ClothesRepository()
  
  var body: some View {
    
    let clothes = clothesRepository.clothes
  
    VStack {
      Text("Clothes Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(clothes) { cloth in
        VStack {
          Text("id: " + cloth.id.uuidString)
          Text("Cloth Title: " + cloth.clothesTitle)
          Text("Category: " + cloth.category)
          Text("Temp added: \(Int(cloth.temperatureAdded))°C")
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


