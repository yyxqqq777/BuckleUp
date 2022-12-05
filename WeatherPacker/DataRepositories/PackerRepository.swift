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
  
  //@Published var packers: [Packer] = []
    var packers: [Packer] = []
  @Published var dailyPackers: [DailyPacker] = []
  @Published var itemsClothes: [Item] = []
  @Published var itemsAccessories: [Item] = []
  @Published var itemsToiletries: [Item] = []
  @Published var itemsElectronics: [Item] = []
  @Published var items: [Item] = []
  @Published var index: Int = 0
  @Published var currentDailyPacker: DailyPacker = DailyPacker(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
  var tripId = UUID()
  var tripLocation = ""
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    
  }
  
  func setCurrentDailyPacker(index: Int) {
    self.index = index
    self.currentDailyPacker = self.dailyPackers[self.index]
  }
  
  func reclear() {
    self.dailyPackers = []
    self.items = []
    self.itemsClothes = []
    self.itemsAccessories = []
    self.itemsToiletries = []
    self.itemsElectronics = []
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
        
        self.reclear()
        
        for packer in self.packers {
          if packer.id.uuidString == tripId.uuidString {
            self.tripId = packer.id
            self.tripLocation = packer.location
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
            }
          }
        }
          self.currentDailyPacker = self.dailyPackers[self.index]
          print("TAG- PacketRepository.get() is called! The length of dailypacker is \(self.dailyPackers.count)  The length of packers is \(self.packers.count) The length of items is \(self.items.count) The length of itemsClothes is \(self.itemsClothes.count)")
      }
  }
  
  func updatePacker(packer:Packer) {
    let packerId = packer.id.uuidString
    
    do {
      try store.collection(path).document(packerId).setData(from:packer)
    } catch {
      fatalError("Unable to update trip collection: \(error.localizedDescription).")
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
  
  func updateCloth(title: String, itemId: UUID) {
    
    for itemIndex in 0..<self.dailyPackers[self.index].itemLists.count {
      if self.dailyPackers[self.index].itemLists[itemIndex].id == itemId {
        self.dailyPackers[self.index].itemLists[itemIndex].itemTitle = title
          //self.currentDailyPacker.itemLists[itemIndex].itemTitle = title
        //self.items[itemindex].itemTitle = title
      }
      break
    }
      print("TAG- updateCloth is called  The length of dailypacker is \(self.dailyPackers.count)")
  }
  
  func saveUpdatePacker() {
    updatePacker(packer: Packer(id: self.tripId, location: self.tripLocation, dailyPackers: self.dailyPackers))
      setCurrentDailyPacker(index: self.index)
      //refreshView()
      print("TAG- saveUpdate is called  The length of dailypacker is \(self.dailyPackers.count)")
  }
  
  func addNewItem(title: String) {
    var item = Item(id: UUID(), itemTitle: title, itemCategory: "Clothes", subCategory: "Customized", isChecked: false, itemQuantity:1)
    self.dailyPackers[self.index].itemLists.append(item)
    self.currentDailyPacker.itemLists.append(item)
  }
  
  func deleteItem(itemId: IndexSet) {
    //    for itemIndex in 0..<self.dailyPackers[self.index].itemLists.count {
    //      if self.dailyPackers[self.index].itemLists[itemIndex].id == itemId {
    //        self.dailyPackers[self.index].itemLists.remove(self.dailyPackers[self.index].itemLists[itemIndex]:Item)
    //self.items[itemindex].itemTitle = title
    self.dailyPackers[self.index].itemLists.remove(atOffsets: itemId)
    self.currentDailyPacker.itemLists.remove(atOffsets: itemId)
  }
}


