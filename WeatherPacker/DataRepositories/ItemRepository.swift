//
//  ClothesRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


class ItemRepository: ObservableObject {
  // Set up properties here
  private let path: String = "Item"
  
  private let store = Firestore.firestore()
  
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
          print("Error getting item: \(error.localizedDescription)")
          return
        }
        
        self.items = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Item.self)
        } ?? []
      
      }
    
    
    // MARK: CRUD methods
    func add(_ item: Item) {
      do {
        let newItem = item
        _ = try store.collection(path).addDocument(from: newItem)
      } catch {
        fatalError("Unable to add item: \(error.localizedDescription).")
      }
    }

    func update(_ item: Item) {
      do {
        let id = item.id.uuidString
        try store.collection(path).document(id).setData(from: item)
      } catch {
        fatalError("Unable to update item: \(error.localizedDescription).")
      }
    }

    func remove(_ item: Item) {
      do {
        let id = item.id.uuidString
        store.collection(path).document(id).delete { error in
          if let error = error {
            print("Unable to remove item: \(error.localizedDescription)")
          }
        }
      }
    }
    
  }
}

