//
//  PackerRepository.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/30/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


class PackerRepository: ObservableObject {
  // Set up properties here
  private let path: String = "Packer"
  
  private let store = Firestore.firestore()
  
  @Published var packers: [Packer] = []
  @Published var dailyPackers: [DailyPacker] = []
  @Published var itemsClothes: [Item] = []
  @Published var itemsAccessories: [Item] = []
  @Published var itemsToiletries: [Item] = []
  @Published var itemsElectronics: [Item] = []
  @Published var items: [Item] = []
  @Published var index: Int = 0
  @Published var currentDailyPacker: DailyPacker = DailyPacker(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    
  }
    
    func setCurrentDailyPacker(index: Int) {
        self.currentDailyPacker = self.dailyPackers[index]
    }
    
    func reclear() {
        self.packers = []
        self.dailyPackers = []
        self.items = []
        self.itemsClothes = []
        self.itemsAccessories = []
        self.itemsToiletries = []
        self.itemsElectronics = []
        self.currentDailyPacker = DailyPacker(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
    }

  func get(tripId: UUID) {
    
    // get clothes data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting trip: \(error.localizedDescription)")
          return
        }
        
        self.packers = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Packer.self)
        } ?? []
        
        
        for packer in self.packers {
          if packer.id.uuidString == tripId.uuidString {
              for dailyPacker in packer.dailyPackers {
                  self.dailyPackers.append(dailyPacker)
                  print(self.dailyPackers)
                  for item in dailyPacker.itemLists {
                      if(item.itemCategory == "Clothes") {
                          self.itemsClothes.append(item)
                      }
                      if(item.itemCategory == "Toiletries") {
                          self.itemsToiletries.append(item)
                      }
                      if(item.itemCategory == "Electronics") {
                          self.itemsElectronics.append(item)
                      }
                      if(item.itemCategory == "Accessories") {
                          self.itemsAccessories.append(item)
                      }
                      self.items.append(item)
                  }
                  print("+++ItemsList")
                  print(self.items)
              }
          }
        }
        self.currentDailyPacker = self.dailyPackers[0]
          print("+++Packer++")
          print(self.dailyPackers)
          print("+++Items+++")
          print(self.items)
          print("+++Clothes")
          print(self.itemsClothes)
          print("+++Toilets")
          print(self.itemsToiletries)
      }
  }
    
    
    // MARK: CRUD methods
    func add(_ packer: Packer) {
      do {
        let id = packer.id.uuidString
        try store.collection(path).document(id).setData(from: packer)
          self.dailyPackers = []
      } catch {
        fatalError("Unable to update dailyOutfitcollection: \(error.localizedDescription).")
      }
    }
    
}


