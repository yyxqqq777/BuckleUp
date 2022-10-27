//
//  Item.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
struct Item: Identifiable, Codable {
  
  var id: UUID
  var listId: String
  var tripId: String
  var itemTitle: String
  var category: String
  var isChecked: Bool
  var quantity: Int
  
  
  enum CodingKeys: String, CodingKey {
    case id
    case listId
    case tripId
    case itemTitle
    case category
    case isChecked
    case quantity
  }
  
}

