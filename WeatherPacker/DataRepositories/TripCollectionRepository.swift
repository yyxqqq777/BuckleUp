//
//  TripCollectionRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


class TripCollectionRepository: ObservableObject {
  // Set up properties here
  private let path: String = "TripCollection"
  
  private let store = Firestore.firestore()
  
  @Published var tripCollection: [TripCollection] = []
  
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
        
        self.tripCollection = querySnapshot?.documents.compactMap { document in
          try? document.data(as: TripCollection.self)
        } ?? []
      
      }
    
    
//    // MARK: CRUD methods
//    func add(_ trip: Trip) {
//      do {
//        let newTrip = trip
//        _ = try store.collection(path).addDocument(from: newTrip)
//      } catch {
//        fatalError("Unable to add trip: \(error.localizedDescription).")
//      }
//    }
//
//    func update(_ trip: Trip) {
//      do {
//        let id = trip.id.uuidString
//        try store.collection(path).document(id).setData(from: trip)
//      } catch {
//        fatalError("Unable to update trip: \(error.localizedDescription).")
//      }
//    }
//
//    func remove(_ trip: Trip) {
//      do {
//        let id = trip.id.uuidString
//        store.collection(path).document(id).delete { error in
//          if let error = error {
//            print("Unable to remove trip: \(error.localizedDescription)")
//          }
//        }
//      }
//    }
    
  }
}


