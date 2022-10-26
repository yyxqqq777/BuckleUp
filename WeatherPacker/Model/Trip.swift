//
//  Trip.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct Trip: Decodable {
  
  var tripId: UUID
  var tripName: String
  var tripLocation: String
  var tripStartDate: Date
  var tripEndDate: Date
  var userId: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case tripId
    case tripName
    case tripLocation
    case tripStartDate
    case tripEndDate
    case userId
  }
  
}

