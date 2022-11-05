//
//  List.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct Outfit: Identifiable, Codable {
  
  var id: UUID
  var lowTemp: Float
  var highTemp: Float
  var date: String
  var weatherCode: String
  var itemLists: [Item]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id = "outfitId"
    case lowTemp
    case highTemp
    case date = "tripDate"
    case weatherCode
    case itemLists
  }
  
}

