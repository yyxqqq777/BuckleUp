//
//  User.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
  
  var id: UUID
  var name: String
  var pwd: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name = "userName"
    case pwd
  }
  
}
