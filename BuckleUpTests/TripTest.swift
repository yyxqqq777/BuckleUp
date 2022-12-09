//
//  TripTest.swift
//  BuckleUpTests
//
//  Created by Yunxuan Yu on 12/8/22.
//

import XCTest
@testable import BuckleUp

final class TripTest: XCTestCase {

    var tripRepository = TripCollectionRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func getTripReposotiry(completion: (_ success: Bool) -> Void) {
        tripRepository.getById(userId: UUID(uuidString: "c71397bf-73b2-4867-ae77-8565c98e3a58")!)
    }


    func testGetTrip() async throws {
        let trip = Trip(id:UUID(uuidString: "120C5403-DA62-497E-9A84-9310188665BC")!, tripLocation:"Berlin", tripStartDate:"2022-12-10", tripEndDate: "2022-12-11", isExpired:false)

        getTripReposotiry { (success) -> Void in
            if success {
                XCTAssertEqual(tripRepository.trips[0].id, trip.id, "Trip Id Not Available")
                XCTAssertEqual(tripRepository.trips[0].tripLocation, trip.tripLocation, "Trip Location Not Available")
                XCTAssertEqual(tripRepository.trips[0].tripStartDate, trip.tripStartDate, "Trip Start Date Not Available")
                XCTAssertEqual(tripRepository.trips[0].tripEndDate, trip.tripEndDate, "Trip End Date Not Available")
                XCTAssertEqual(tripRepository.trips[0].isExpired, trip.isExpired, "Trip Expiration Not Available")
            }
        }
    }

    func testUpdateTrip() throws {
        getTripReposotiry { (success) -> Void in
            if success {
                tripRepository.trips[0].isExpired = true
                tripRepository.updateTrip(tripCollection: TripCollection(id: UUID(uuidString: "120C5403-DA62-497E-9A84-9310188665BC")!, trips: tripRepository.trips))
                XCTAssertEqual(tripRepository.trips[0].isExpired, true, "Trip Not Updated Correctly")
            }
        }
    }

}
