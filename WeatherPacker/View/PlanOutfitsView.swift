//
//  PlanOutfitsView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/8/22.
//

import SwiftUI

struct PlanOutfitsView: View {
  @ObservedObject var dailyOutfitCollectionRepo = DailyOutfitCollectionRepository()

    var body: some View {
      var outfits = dailyOutfitCollectionRepo.outfits
      
      VStack(alignment: .leading) {
        HStack {
          ForEach(outfits) { outfit in
            RoundedRectangle(cornerRadius: 8)
              .fill(Color("PrimaryOrange"))
              .frame(width: 80, height: 40)
              .overlay(Text(outfit.date))
          }
        }.padding()
        Text("Outfit")
        Spacer()
      }
    }
}

struct PlanOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanOutfitsView()
    }
}
