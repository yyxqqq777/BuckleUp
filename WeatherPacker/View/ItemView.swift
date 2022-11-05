//
//  ItemView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ItemView: View {
  @ObservedObject var dailyOutfitCollectionRepository = DailyOutfitCollectionRepository()
  
  var body: some View {
    
    let items = dailyOutfitCollectionRepository.items
  
    VStack {
      Text("Item Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(items) { item in
        VStack {
          Text("ID: " + item.id.uuidString)
          Text("Category: " + item.itemCategory)
          Text("Title: " + item.itemTitle)
          HStack {
            Text("IsChecked: ")
            Text(item.isChecked ? "true" : "false")
          }
          Text("Quantity: \(item.itemQuantity)")
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


