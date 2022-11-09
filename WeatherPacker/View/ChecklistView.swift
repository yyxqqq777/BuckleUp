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
        Text(item.itemTitle)
      }
    }
}

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
