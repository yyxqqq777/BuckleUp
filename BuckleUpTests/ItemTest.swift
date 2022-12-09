//
//  ItemTest.swift
//  BuckleUpTests
//
//  Created by Yunxuan Yu on 12/8/22.
//

import XCTest
@testable import BuckleUp

final class ItemTest: XCTestCase {

    var packerRepository = PackerRepository()

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
