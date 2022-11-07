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
        self.trips = tripRepo.trips
    }
    
    func update(userId:UUID,location:String,startDate:Date,endDate:Date) {
        let datefmt = DateFormatter()
        datefmt.dateFormat = "yyyy-MM-dd"
        var trip = Trip(id:userId, tripLocation: location, tripStartDate: datefmt.string(from: startDate), tripEndDate: datefmt.string(from: endDate), isExpired: false)
        tripRepo.trips.append(trip)
        tripRepo.updateTrip(tripCollection: TripCollection(id: userId, trips: tripRepo.trips))
    }
}
