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


class ClothesRepository: ObservableObject {
  // Set up properties here
  private let path: String = "Clothes"
  
  private let store = Firestore.firestore()
  
  @Published var clothes: [Clothes] = []
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    
    // get clothes data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting clothes: \(error.localizedDescription)")
          return
        }
        
        self.clothes = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Clothes.self)
        } ?? []
      
      }
    
    
    // MARK: CRUD methods
    func add(_ clothes: Clothes) {
      do {
        let newClothes = clothes
        _ = try store.collection(path).addDocument(from: newClothes)
      } catch {
        fatalError("Unable to add clothes: \(error.localizedDescription).")
      }
    }

    func update(_ clothes: Clothes) {
      do {
        let id = clothes.id.uuidString
        try store.collection(path).document(id).setData(from: clothes)
      } catch {
        fatalError("Unable to update clothes: \(error.localizedDescription).")
      }
    }

    func remove(_ clothes: Clothes) {
      do {
        let id = clothes.id.uuidString
        store.collection(path).document(id).delete { error in
          if let error = error {
            print("Unable to remove clothes: \(error.localizedDescription)")
          }
        }
      }
    }
    
  }
}

