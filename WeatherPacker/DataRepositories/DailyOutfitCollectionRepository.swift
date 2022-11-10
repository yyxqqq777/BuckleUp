//
//  DailyOutfitRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


class DailyOutfitCollectionRepository: ObservableObject {
  // Set up properties here
  private let path: String = "DailyOutfitCollection"
  
  private let store = Firestore.firestore()
  
  @Published var dailyOutfitCollection: [DailyOutfitCollection] = []
  @Published var outfits: [Outfit] = []
  @Published var items: [Item] = []
  @Published var index: Int = 0
  @Published var currentOutfit: Outfit = Outfit(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    
  }
    
    func reclear() {
        self.dailyOutfitCollection = []
        self.outfits = []
        self.items = []
        self.currentOutfit = Outfit(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
    }

  func get(tripId: UUID) {
    
    // get clothes data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting trip: \(error.localizedDescription)")
          return
        }
        
        self.dailyOutfitCollection = querySnapshot?.documents.compactMap { document in
          try? document.data(as: DailyOutfitCollection.self)
        } ?? []
        
        
        for collection in self.dailyOutfitCollection {
          if collection.id.uuidString == tripId.uuidString {
            for outfit in collection.outfits {
              self.outfits.append(outfit)
              for item in outfit.itemLists {
                self.items.append(item)
              }
            }
          }
        }
        self.currentOutfit = self.outfits[0]
      }
  }
    
    
    // MARK: CRUD methods
    func add(_ dailyOutfitcollection: DailyOutfitCollection) {
      do {
        let id = dailyOutfitcollection.id.uuidString
        try store.collection(path).document(id).setData(from: dailyOutfitcollection)
      } catch {
        fatalError("Unable to update dailyOutfitcollection: \(error.localizedDescription).")
      }
    }
    
}


