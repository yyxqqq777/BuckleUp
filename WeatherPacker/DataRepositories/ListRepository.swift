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


class ListRepository: ObservableObject {
  // Set up properties here
  private let path: String = "List"
  
  private let store = Firestore.firestore()
  
  @Published var lists: [List] = []
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    
    // get clothes data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting list: \(error.localizedDescription)")
          return
        }
        
        self.lists = querySnapshot?.documents.compactMap { document in
          try? document.data(as: List.self)
        } ?? []
      
      }
    
    
    // MARK: CRUD methods
    func add(_ list: List) {
      do {
        let newList = list
        _ = try store.collection(path).addDocument(from: newList)
      } catch {
        fatalError("Unable to add list: \(error.localizedDescription).")
      }
    }

    func update(_ list: List) {
      do {
        let id = list.id.uuidString
        try store.collection(path).document(id).setData(from: list)
      } catch {
        fatalError("Unable to update list: \(error.localizedDescription).")
      }
    }

    func remove(_ list: List) {
      do {
        let id = list.id.uuidString
        store.collection(path).document(id).delete { error in
          if let error = error {
            print("Unable to remove list: \(error.localizedDescription)")
          }
        }
      }
    }
    
  }
}

