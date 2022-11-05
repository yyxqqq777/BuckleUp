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
  var tripLocation: String
  var tripStartDate: String
  var tripEndDate: String
  var isExpired: Bool
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id = "tripId"
    case tripLocation
    case tripStartDate
    case tripEndDate
    case isExpired
  }
  
}

