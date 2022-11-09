//
//  TripController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class DailyOutfitController: ObservableObject {
  private var dailyOutfitRepo: DailyOutfitCollectionRepository
  
  init() {
    self.dailyOutfitRepo = DailyOutfitCollectionRepository()
  }
  
  func changeIndex(index: Int) {
    self.dailyOutfitRepo.index = index
  }
  
}
