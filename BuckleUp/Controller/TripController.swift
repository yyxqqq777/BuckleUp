//
//  TripController.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/30/22.
//

import Foundation

class TripController: ObservableObject {
    private var trips:[Trip] = []
    private let datefmtNumericMonth = DateFormatter()
    private let datefmtShorthandMonth = DateFormatter()
    private let datefmtShorthandMonthDot = DateFormatter()

    init() {
        datefmtNumericMonth.dateFormat = "yyyy-MM-dd"
        datefmtShorthandMonth.dateFormat = "MMM-dd"
        datefmtShorthandMonthDot.dateFormat = "MMM.dd"
    }

    func update(userId:UUID,location:String,startDate:Date,endDate:Date, tripRepo:TripCollectionRepository) -> UUID {
        let tripId = UUID()
        var trip = Trip(id:tripId, tripLocation: location, tripStartDate: datefmtNumericMonth.string(from: startDate), tripEndDate: datefmtNumericMonth.string(from: endDate), isExpired: false)
        tripRepo.trips.append(trip)
        tripRepo.tripsNotExpired.append(trip)
        tripRepo.updateTrip(tripCollection: TripCollection(id: userId, trips: tripRepo.trips))
        return tripId
    }

    func calculateDate(startDateString:String, index: Int) -> String {
        let startDate = datefmtNumericMonth.date(from: startDateString)
        let date = startDate?.addingTimeInterval(TimeInterval(86400 * index))
        return datefmtShorthandMonth.string(from: date!)
    }

    func calculateDateDot(startDateString:String) -> String {
        let startDate = datefmtNumericMonth.date(from: startDateString)
        return datefmtShorthandMonthDot.string(from: startDate!)
    }
}
