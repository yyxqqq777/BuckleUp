//
//  ChecklistView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/9/22.
//

import SwiftUI

struct ChecklistView: View {
  @EnvironmentObject var dailyOutfitCollectionRepo:DailyOutfitCollectionRepository
    
    var body: some View {
      let items = dailyOutfitCollectionRepo.items
      
      List(items) { item in
          HStack {
              Text(item.itemTitle)
              Spacer()
              Text(String(item.itemQuantity))
          }
        
      }
    }
}

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
