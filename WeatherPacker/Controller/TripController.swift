//
//  TripController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class TripController: ObservableObject {
    private var tripRepo:TripCollectionRepository
    private var trips:[Trip] = []
    
    init() {
        tripRepo = TripCollectionRepository()
    }
    
    func update(userId:UUID,location:String,startDate:Date,endDate:Date) -> UUID {
        self.trips = tripRepo.getTripById(userId: userId.uuidString)
        print("---------tripsCollection-----------\(tripRepo.tripCollection)")
        print("---------trips-----------\(tripRepo.trips)")
        let datefmt = DateFormatter()
        datefmt.dateFormat = "yyyy-MM-dd"
        let tripId = UUID()
        var trip = Trip(id:tripId, tripLocation: location, tripStartDate: datefmt.string(from: startDate), tripEndDate: datefmt.string(from: endDate), isExpired: false)
        self.trips.append(trip)
        tripRepo.updateTrip(tripCollection: TripCollection(id: userId, trips: self.trips))
        return tripId
    }
}
