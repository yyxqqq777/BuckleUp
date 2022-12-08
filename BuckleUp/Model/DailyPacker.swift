//
//  DailyPacker.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/30/22.
//

import Foundation

struct DailyPacker: Identifiable, Codable {
  
  var id: UUID
  var lowTemp: Float
  var highTemp: Float
  var date: String
  var weatherCode: String
  var itemLists: [Item]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id = "dailyPackerId"
    case lowTemp
    case highTemp
    case date = "tripDate"
    case weatherCode
    case itemLists
  }
  
}
