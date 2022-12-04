//
//  TripController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class TripController: ObservableObject {
    private var trips:[Trip] = []
    
    init() {
    }
    
    func update(userId:UUID,location:String,startDate:Date,endDate:Date, tripRepo:TripCollectionRepository) -> UUID {
        //self.trips = tripRepo.getTripById(userId: userId.uuidString)
        print("---------tripsCollection-----------\(tripRepo.tripCollection)")
        print("---------trips-----------\(tripRepo.trips)")
        let datefmt = DateFormatter()
        datefmt.dateFormat = "yyyy-MM-dd"
        let tripId = UUID()
        var trip = Trip(id:tripId, tripLocation: location, tripStartDate: datefmt.string(from: startDate), tripEndDate: datefmt.string(from: endDate), isExpired: false)
        tripRepo.tripsAll.append(trip)
        tripRepo.tripsNotExpired.append(trip)
        tripRepo.updateTrip(tripCollection: TripCollection(id: userId, trips: tripRepo.tripsAll))
        print("--------after update-trips-----------\(tripRepo.trips)")
        tripRepo.trips = []
        return tripId
    }
}
