//
//  ItemTest.swift
//  WeatherPackerTests
//
//  Created by 薛渤凡 on 12/7/22.
//

import XCTest
@testable import WeatherPacker

final class ItemTest: XCTestCase {
    
    var packerRepository = PackerRepository()

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
    
    func getpackerReposotiry(completion: (_ success: Bool) -> Void) {
        packerRepository.get(tripId: UUID(uuidString: "120C5403-DA62-497E-9A84-9310188665BC")!)
    }
    
    
    func testGetItem() throws {
        getpackerReposotiry {  (success) -> Void in
            if success {
                XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].itemTitle, "Medium Coat", "Item Title Not Available")
                XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].itemQuantity, 1, "Item Quantity Not Available")
                XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].itemCategory, "Clothes", "Item Category Not Available")
                XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].subCategory, "Coat", "Item Sub-Category Not Available")
                XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].isChecked, false, "Item Status Not Available")
            }
        }
    }
    
    func updateItemByTitle (completion: (_ success: Bool) -> Void) {
        packerRepository.updateChecklistByTitle(title: "Blue Medium Coat", itemId: UUID(uuidString: "37E0602C-3ADE-4F0B-B0B6-B7CEDDEA19C8")!)
    }
    
    func testUpdateItemByTitle() throws {
        getpackerReposotiry {  (success) -> Void in
            if success {
                updateItemByTitle {  (success) -> Void in
                    if success {
                        XCTAssertEqual(packerRepository.dailyPackers[0].itemLists[0].itemTitle, "Blue Medium Coat", "Item Title Not Update Correctly")
                    }
                }
            
            }
        }
    }
    
}
