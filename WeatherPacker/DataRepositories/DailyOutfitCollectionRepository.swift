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
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    
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
          for outfit in collection.outfits {
            self.outfits.append(outfit)
            for item in outfit.itemLists {
              self.items.append(item)
            }
          }
        }
        
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



