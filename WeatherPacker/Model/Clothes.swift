//
//  Clothes.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct Clothes: Decodable {
  
  var clothesId: UUID
  var clothesTitle: String
  var category: String
  var temperatureAdded: Float
  
  enum CodingKeys: String, CodingKey {
    case clothesId
    case clothesTitle
    case category
    case temperatureAdded
  }
  
}
