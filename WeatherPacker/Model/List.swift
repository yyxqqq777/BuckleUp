//
//  List.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct List: Decodable {
  
  var tripId: UUID
  var lowTemp: Float
  var highTemp: Float
  var date: Date
  var listCategory: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case tripId
    case lowTemp
    case highTemp
    case date
    case listCategory
  }
  
}

