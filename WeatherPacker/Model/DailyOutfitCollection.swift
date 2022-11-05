//
//  TripListCollection.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import Foundation
import SwiftUI

struct DailyOutfitCollection: Identifiable, Codable {
  
  var id: UUID
  var location: String
  var outfits: [Outfit]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case location
    case outfits
  }
  
}
