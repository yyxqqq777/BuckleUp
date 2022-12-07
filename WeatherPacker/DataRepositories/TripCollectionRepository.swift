//
//  TripCollectionRepository.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22
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
  @Published var tripsExpired: [Trip] = []
  @Published var tripsNotExpired: [Trip] = []
    var isChecked = false
  
  private var cancellables: Set<AnyCancellable> = []
  
    init() {
        print("UnitTest: tripCollectionRepository initialized")
  }
  
    func refreshContains(){
        self.trips = []
    }
    
    func getById(userId:UUID) {
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
            
            self.refreshContains()
            
            print("UnitTest: start finding trips")
            for collection in self.tripCollection {
                if collection.id.uuidString == userId.uuidString {
                    for trip in collection.trips {
                        self.trips.append(trip)
                        print("UnitTest: append trips")
                    }
                    break
                }
            }
            self.isChecked = false
            self.tripsExpired = []
            self.tripsNotExpired = []
          
            if (!self.isChecked) {
                for tripIndex in 0..<self.trips.count {
                    if self.trips[tripIndex].isExpired == true {
                        self.tripsExpired.append(self.trips[tripIndex])
                    } else {
                        let datefmt = DateFormatter()
                        datefmt.dateFormat = "yyyy-MM-dd"
                        let now = Date()
                        let current = datefmt.string(from: now)
                        if(current > self.trips[tripIndex].tripEndDate) {
                            self.trips[tripIndex].isExpired = true
                            self.tripsExpired.append(self.trips[tripIndex])
                        } else {
                            self.tripsNotExpired.append(self.trips[tripIndex])
                        }
                    }
                }
                self.isChecked = true
                self.updateTrip(tripCollection: TripCollection(id: userId, trips: self.trips))
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
    
    func getTripById(userId:String) -> [Trip] {
          
          for collection in self.tripCollection {
              if collection.id.uuidString == userId {
                  
                  for trip in collection.trips {
                    self.trips.append(trip)
                  }
                  break
              }
          }
        return self.trips
    }
}
