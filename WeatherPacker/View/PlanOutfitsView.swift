//
//  PlanOutfitsView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/8/22.
//

import SwiftUI

struct PlanOutfitsView: View {
  @ObservedObject var dailyOutfitController = DailyOutfitController()
//  @State var length = 0

    var body: some View {
      let outfits = dailyOutfitController.outfits
      
      VStack {
        ForEach(outfits) { outfit in
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(red: 255 / 255, green: 125 / 255, blue: 13 / 255))
            .frame(width: 80, height: 40)
            .overlay(Text(outfit.date))
        }
      }
    }
}

struct PlanOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanOutfitsView()
    }
}
