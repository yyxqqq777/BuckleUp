//
//  Packer.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/30/22.
//

import Foundation

struct Packer: Identifiable, Codable {
  
  var id: UUID
  var location: String
  var dailyPackers: [DailyPacker]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case location
    case dailyPackers
  }
  
}
