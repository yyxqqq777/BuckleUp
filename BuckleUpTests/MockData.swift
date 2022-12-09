//
//  MockData.swift
//  BuckleUpTests
//
//  Created by Yunxuan Yu on 12/8/22.
//

import Foundation
let mockUser1 = ["id": "A4B1A196-5E05-4A03-ADF8-7AD019C27410", "pwd": "123456", "userName": "Test"]
let mockUser2 = ["id": "b5b9c8cc-c96c-42b1-b62d-a409877573f4", "pwd": "123123", "userName": "Yyx"]
let mockUsers = [mockUser1, mockUser2]

let mockTrip1 = ["tripId": "DCE163F0-E561-46FD-8B88-8667D5296E8E",
             "isExpired": false,
             "tripEndDate": "2022-11-09",
             "tripStartDate": "2022-11-12",
                 "tripLocation": "Boston"] as [String : Any]
let mockTrips = [mockTrip1]

let mockTripCollection = ["UserId": "A4B1A196-5E05-4A03-ADF8-7AD019C27410", "trips": mockTrips] as [String : Any]

let mockItem1 = ["id": "E51E589D-FDC5-4F03-9654-EFC33FA394CC", "itemTitle": "Winter Jacket", "itemCategory": "Clothes", "subCategory": "Jacket", "isChecked": false, "itemQuantity": 1] as [String : Any]

let mockItem2 = ["id": "D0C08E75-9CFE-4598-89F9-C3374FC66376", "itemTitle": "Sweater", "itemCategory": "Clothes", "subCategory": "Sweater", "isChecked": false, "itemQuantity": 2] as [String : Any]

let mockItemList = [mockItem1, mockItem2]

let mockDailyPacker = ["id": "80C309FA-2CCA-4FB6-97E9-F6D6670D5F79", "lowTemp": -10.6, "highTemp": -3.3, "date": "Day 2", "weatherCode": "3", "itemLists": mockItemList] as [String : Any]

let mockDailyPackers = [mockDailyPacker]

let mockPackerCollection = ["id": "0705DE7C-A907-4F64-AADB-3FE54D333CED", "location": "Anchorage", "dailyPackers": mockDailyPackers] as [String : Any]
