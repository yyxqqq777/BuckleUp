//
//  TripController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class DailyOutfitController: ObservableObject {
  private var dailyOutfitRepo: DailyOutfitCollectionRepository
  
  @Published var currentDailyOutfits: DailyOutfitCollection
  @Published var index: Int
  
  init() {
    self.dailyOutfitRepo = DailyOutfitCollectionRepository()
    self.currentDailyOutfits = DailyOutfitCollection(id: UUID(), location: "", outfits: [])
    for collection in self.dailyOutfitRepo.dailyOutfitCollection {
      if collection.id == UUID(uuidString: "37BA2F60-ED6D-45FC-8D34-AB2261D75A60")! {
        self.currentDailyOutfits = collection
        break
      }
    }
    
    self.index = 0
  }
  
}
