//
//  ListView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct OutfitView: View {
  @ObservedObject var dailyOutfitCollectionRepository = DailyOutfitCollectionRepository()
  
  
//  func update(outfits: [Outfit]) {
//    dailyOutfitCollectionRepository.update(DailyOutfitCollection(id: UUID(uuidString: "")!, location: "", outfits: outfits))
//  }
  
  
  func add() {
    var item1: Item = Item(id: UUID(), itemTitle: "Jeans", itemCategory: "Clothes", isChecked: false, itemQuantity: 1)
    var item2: Item = Item(id: UUID(), itemTitle: "Shirt", itemCategory: "Clothes", isChecked: false, itemQuantity: 2)
    
    var itemLists: [Item] = []
    itemLists.append(item1)
    itemLists.append(item2)
    
    var outfit1: Outfit = Outfit(id: UUID(), lowTemp: 12, highTemp: 22, date: "2022-11-02", weatherCode: "03", itemLists: itemLists)
    var outfits: [Outfit] = []
    outfits.append(outfit1)
    dailyOutfitCollectionRepository.add(DailyOutfitCollection(id: UUID(), location: "Shanghai", outfits: outfits))
  }
  
  var body: some View {
    
    let outfits = dailyOutfitCollectionRepository.outfits

    
    VStack {
      Text("Outfit Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(outfits) { outfit in
        VStack {
          Text("Id: " + outfit.id.uuidString)
          Text("Category: " + outfit.weatherCode)
          Text("Date: " + outfit.date)
          Text("High temp: \(Int(outfit.highTemp))°C")
          Text("Low temp: \(Int(outfit.lowTemp))°C")
          Text("Weather Code: " + outfit.weatherCode)
        }
      }
      Button(action: {
        add()
      }) {
        Text("Add new trip")
      }
    }
  }
}

struct OutfitView_Previews: PreviewProvider {
  static var previews: some View {
    OutfitView()
  }
}

