//
//  Trip.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct Trip: Identifiable, Codable {
  
  var id: UUID
  var tripName: String
  var tripLocation: String
  var tripStartDate: Date
  var tripEndDate: Date
  var userId: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case tripName
    case tripLocation
    case tripStartDate
    case tripEndDate
    case userId
  }
  
//  // To conform to Comparable protocol
//  static func < (lhs: Trip, rhs: Trip) -> Bool {
//    lhs.tripStartDate < rhs.tripStartDate
//  }
//  
//  static func == (lhs: Trip, rhs: Trip) -> Bool {
//    lhs.tripStartDate == rhs.tripStartDate
//  }
  
}

