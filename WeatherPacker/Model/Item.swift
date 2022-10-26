//
//  Item.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
struct Item: Decodable {
  
  var tripId: UUID
  var date: Date
  var listCategory: String
  var itemTitle: Float
  var category: String
  var isChecked: Bool
  
  
  enum CodingKeys: String, CodingKey {
    case tripId
    case date
    case listCategory
    case itemTitle
    case category
    case isChecked
  }
  
}

