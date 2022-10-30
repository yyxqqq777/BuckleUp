//
//  ItemView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/26/22.
//

import SwiftUI

struct ItemView: View {
  @ObservedObject var itemRepository = ItemRepository()
  
  var body: some View {
    
    let items = itemRepository.items
  
    VStack {
      Text("Item Data").padding(12).font(Font.headline.weight(.bold))
      ForEach(items) { item in
        VStack {
          Text("ID: " + item.id.uuidString)
          Text("Category: " + item.category)
          Text("Title: " + item.itemTitle)
          HStack {
            Text("IsChecked: ")
            Text(item.isChecked ? "true" : "false")
          }
          Text("Quantity: \(item.quantity)")
          Text("Trip Id: " + item.tripId)
          Text("List Id: " + item.listId)
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


