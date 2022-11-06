//
//  TripCollection.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import Foundation
import SwiftUI

struct TripCollection: Identifiable, Codable {
  
  var id: UUID
  var trips: [Trip]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id = "UserId"
    case trips = "trips"
  }
  
}

