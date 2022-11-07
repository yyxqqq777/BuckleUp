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
  @Published var trips: [Trip] = []
  
  private var cancellables: Set<AnyCancellable> = []
  
    init() {
      self.get()
      //self.getById(userId: userId)
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
        
//        for collection in self.tripCollection {
//          for trip in collection.trips {
//            self.trips.append(trip)
//          }
//        }
      }
  }
    
    func getById(userId:String) {
      
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
          
          for collection in self.tripCollection {
              if collection.id.uuidString == userId {
                  
                  for trip in collection.trips {
                    self.trips.append(trip)
                  }
                  break
              }
          }
        }
    }
    
    func updateTrip(tripCollection:TripCollection) {
        let tripCollectionId = tripCollection.id.uuidString
        
        do {
            try store.collection(path).document(tripCollectionId).setData(from:tripCollection)
        } catch {
            fatalError("Unable to update trip collection: \(error.localizedDescription).")
        }
    }
}


