//
//  Item.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
struct Item: Identifiable, Codable {
  
  var id: UUID
  var itemTitle: String
  var itemCategory: String
  var isChecked: Bool
  var itemQuantity: Int
  
  
  enum CodingKeys: String, CodingKey {
    case id = "itemId"
    case itemTitle
    case itemCategory
    case isChecked
    case itemQuantity
  }
  
}

