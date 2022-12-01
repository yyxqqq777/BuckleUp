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
              for item in dailyPacker.itemLists {
                self.items.append(item)
              }
            }
          }
        }
        self.currentDailyPacker = self.dailyPackers[0]
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


