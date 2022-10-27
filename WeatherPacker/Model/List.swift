//
//  List.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct List: Identifiable, Codable {
  
  var id: UUID
  var tripId: String
  var lowTemp: Float
  var highTemp: Float
  var date: String
  var listCategory: String
  var weatherCode: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case tripId
    case lowTemp
    case highTemp
    case date
    case listCategory
    case weatherCode
  }
  
}

