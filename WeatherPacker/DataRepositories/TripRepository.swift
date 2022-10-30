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


class TripRepository: ObservableObject {
  // Set up properties here
  private let path: String = "Trip"
  
  private let store = Firestore.firestore()
  
  @Published var trips: [Trip] = []
  
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
        
        self.trips = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Trip.self)
        } ?? []
      
      }
    
    
    // MARK: CRUD methods
    func add(_ trip: Trip) {
      do {
        let newTrip = trip
        _ = try store.collection(path).addDocument(from: newTrip)
      } catch {
        fatalError("Unable to add trip: \(error.localizedDescription).")
      }
    }

    func update(_ trip: Trip) {
      do {
        let id = trip.id.uuidString
        try store.collection(path).document(id).setData(from: trip)
      } catch {
        fatalError("Unable to update trip: \(error.localizedDescription).")
      }
    }

    func remove(_ trip: Trip) {
      do {
        let id = trip.id.uuidString
        store.collection(path).document(id).delete { error in
          if let error = error {
            print("Unable to remove trip: \(error.localizedDescription)")
          }
        }
      }
    }
    
  }
}

