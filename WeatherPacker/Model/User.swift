//
//  User.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct User: Decodable {
  
  var userId: UUID
  var userName: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case userId
    case userName
  }
  
}
