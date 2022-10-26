//
//  Clothes.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct Clothes: Identifiable, Codable {
  
  var id: UUID
  var clothesTitle: String
  var category: String
  var temperatureAdded: Float
  
  enum CodingKeys: String, CodingKey {
    case id
    case clothesTitle
    case category
    case temperatureAdded
  }
  
}
