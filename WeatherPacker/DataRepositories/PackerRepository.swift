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
  @Published var aggregatedClothes: [Item] = []
  @Published var index: Int = 0
  @Published var currentDailyPacker: DailyPacker = DailyPacker(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
  @Published var checklistPacker: DailyPacker = DailyPacker(id: UUID(), lowTemp: 0.0, highTemp: 0.0, date: "", weatherCode: "", itemLists: [])
  var clothTitle: [String] = []
  var tripId = UUID()
  var tripLocation = ""
  var lasting = 0
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    
  }
  
  func setCurrentDailyPacker(index: Int) {
    self.index = index
    self.currentDailyPacker = self.dailyPackers[self.index]
  }
    
    func setChecklistPacker() {
      self.checklistPacker = self.dailyPackers[self.lasting]
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
              for item in dailyPacker.itemLists {
                  self.items.append(item)
              }
            }
          }
        }
          self.lasting = self.dailyPackers.count - 1
          self.currentDailyPacker = self.dailyPackers[self.index]
          self.checklistPacker = self.dailyPackers[self.lasting]
          self.aggregateClothes()
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
      print("VERSION 2 - updateCloth is called!")
      for itemIndex in 0..<self.dailyPackers[self.index].itemLists.count {
          print("VERSION 2 - Searching for cloth")
          print("VERSION 2 - Size of itemLists is \(self.dailyPackers[self.index].itemLists.count)")
          print("VERSION 2 - Searching for cloth")
          if self.dailyPackers[self.index].itemLists[itemIndex].id == itemId {
              print("VERSION 2 - Cloth is found!")
              self.dailyPackers[self.index].itemLists[itemIndex].itemTitle = title
              //self.currentDailyPacker.itemLists[itemIndex].itemTitle = title
              //self.items[itemindex].itemTitle = title
              break
          }
    }
  }
    
    func updateChecklistByTitle(title: String, itemId: UUID) {
        print("VERSION 2 - updateChecklistByTitle is called!")
        for itemIndex in 0..<self.dailyPackers[self.lasting].itemLists.count {
            print("VERSION 2 - Searching for checklist item")
            if self.dailyPackers[self.lasting].itemLists[itemIndex].id == itemId {
                print("VERSION 2 - checklist item is found")
                self.dailyPackers[self.lasting].itemLists[itemIndex].itemTitle = title
                break
            }
        }
    }
  
    func updateItemCheckStatus(itemId: UUID, itemTitle: String, itemCategory: String) {
          print("VERSION 2 - updateItemCheckStatueById is called!")
        if (itemCategory != "Clothes") {
            for itemIndex in 0..<self.dailyPackers[self.lasting].itemLists.count {
                print("VERSION 2 - Searching for checklist item")
                if self.dailyPackers[self.lasting].itemLists[itemIndex].id == itemId {
                    print("VERSION 2 - checklist item is found")
                  self.dailyPackers[self.lasting].itemLists[itemIndex].isChecked.toggle()
                    break
                }
            }
        } else {
            for index in 0..<(self.lasting + 1) {
                for itemIndex in 0..<self.dailyPackers[index].itemLists.count {
                    if self.dailyPackers[index].itemLists[itemIndex].itemCategory == "Clothes" {
                        if (self.dailyPackers[index].itemLists[itemIndex].itemTitle == itemTitle) {
                            self.dailyPackers[index].itemLists[itemIndex].isChecked.toggle()
                        }
                    }
                }
            }
        }
      }
    
//    func updateChecklistByQuantity(quantity: Int, itemId: UUID) {
//
//        for itemIndex in 0..<self.dailyPackers[self.lasting].itemLists.count {
//            if self.dailyPackers[self.lasting].itemLists[itemIndex].id == itemId {
//                self.dailyPackers[self.lasting].itemLists[itemIndex].itemQuantity = quantity
//        }
//        break
//      }
//    }
    
    func aggregateClothes() {
        self.aggregatedClothes = []
        self.clothTitle = []
        for index in 0..<(self.lasting + 1) {
            for itemIndex in 0..<self.dailyPackers[index].itemLists.count {
                let item = self.dailyPackers[index].itemLists[itemIndex]
                if item.itemCategory == "Clothes" {
                    if clothTitle.contains(item.itemTitle) {
                        for clothIndex in 0..<self.aggregatedClothes.count {
                            if self.aggregatedClothes[clothIndex].itemTitle == item.itemTitle {
                                self.aggregatedClothes[clothIndex].itemQuantity = self.aggregatedClothes[clothIndex].itemQuantity + 1
                                break
                            }
                        }
                    } else {
                        clothTitle.append(item.itemTitle)
                        self.aggregatedClothes.append(item)
                    }
                }
            }
        }
    }
    
    
    func updateChecklistByQuantity(isAdd: Bool, itemId: UUID) {
        print("VERSION 2 - updateChecklistByQuantity is called!")
        if isAdd {
            for itemIndex in 0..<self.dailyPackers[self.lasting].itemLists.count {
                if self.dailyPackers[self.lasting].itemLists[itemIndex].id == itemId {
                    self.dailyPackers[self.lasting].itemLists[itemIndex].itemQuantity = self.dailyPackers[self.lasting].itemLists[itemIndex].itemQuantity + 1
                    print("VERSION 2 - add 1")
                    return
                }
          }
        } else {
            for itemIndex in 0..<self.dailyPackers[self.lasting].itemLists.count {
                if self.dailyPackers[self.lasting].itemLists[itemIndex].id == itemId {
                    self.dailyPackers[self.lasting].itemLists[itemIndex].itemQuantity = self.dailyPackers[self.lasting].itemLists[itemIndex].itemQuantity - 1
                    print("VERSION 2 - minus 1")
                    return
                }
            }
        }
    }
  
  func saveUpdatePacker() {
      print("VERSION 2 - saveUpdatePacker is called!")
      updatePacker(packer: Packer(id: self.tripId, location: self.tripLocation, dailyPackers: self.dailyPackers))
      setCurrentDailyPacker(index: self.index)
      setChecklistPacker()
      self.aggregateClothes()
  }
  
  func addNewItem(title: String) {
    var item = Item(id: UUID(), itemTitle: title, itemCategory: "Clothes", subCategory: "Customized", isChecked: false, itemQuantity:1)
    self.dailyPackers[self.index].itemLists.append(item)
    self.currentDailyPacker.itemLists.append(item)
  }
    
    func addNewItemFromChecklist(title:String, category:String) {
        var item = Item(id: UUID(), itemTitle: title, itemCategory: category, subCategory: "Customized", isChecked: false, itemQuantity:1)
        self.dailyPackers[self.lasting].itemLists.append(item)
        self.checklistPacker.itemLists.append(item)
    }
  
  func deleteItem(itemId: IndexSet) {
    self.dailyPackers[self.index].itemLists.remove(atOffsets: itemId)
    self.currentDailyPacker.itemLists.remove(atOffsets: itemId)
  }
    
    func deleteItemFromChecklist(itemId: IndexSet) {
        self.dailyPackers[self.lasting].itemLists.remove(atOffsets: itemId)
        self.checklistPacker.itemLists.remove(atOffsets: itemId)
    }
}


