//
//  LocationRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift




class LocationRepository: ObservableObject {
  // Set up properties here
  private let userPath: String = "User"
  private let itemPath: String = "Item"
  private let tripPath: String = "Trip"
  private let listPath: String = "List"
  private let clothesPath: String = "Clothes"
  
  private let store = Firestore.firestore()
  
  @Published var user: [User] = []
  @Published var items: [Item] = []
  @Published var trips: [Trip] = []
  @Published var lists: [List] = []
  @Published var clothes: [Clothes] = []
  
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    // get user data
    store.collection(userPath)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting user: \(error.localizedDescription)")
          return
        }
        
        self.user = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
        
      }
    
    // get items data
    store.collection(itemPath)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting items: \(error.localizedDescription)")
          return
        }
        
        self.items = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Item.self)
        } ?? []
      }
    
    // get trips data
    store.collection(tripPath)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting trips: \(error.localizedDescription)")
          return
        }
        
        self.trips = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Trip.self)
        } ?? []
        
        print(self.trips)
      }
    
    // get clothes data
    store.collection(clothesPath)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting clothes: \(error.localizedDescription)")
          return
        }
        
        self.clothes = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Clothes.self)
        } ?? []
      }
    
    // get lists data
    store.collection(listPath)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting lists: \(error.localizedDescription)")
          return
        }
        
        self.lists = querySnapshot?.documents.compactMap { document in
          try? document.data(as: List.self)
        } ?? []
      }
    
  
  }
}

