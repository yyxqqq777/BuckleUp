//
//  PlanOutfitsView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/8/22.
//

import SwiftUI

struct PlanOutfitsView: View {
  @EnvironmentObject var dailyOutfitCollectionRepo:DailyOutfitCollectionRepository

    var body: some View {
      let outfits = self.dailyOutfitCollectionRepo.outfits
      let currentOutfit = self.dailyOutfitCollectionRepo.currentOutfit
      
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
//            ForEach(outfits) { outfit in
//              RoundedRectangle(cornerRadius: 8)
//                .fill(Color("PrimaryOrange"))
//                .frame(width: 80, height: 40)
//                .overlay(Text(outfit.date))
//            }
              ForEach(0..<outfits.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color("PrimaryOrange"))
                  .frame(width: 90, height: 30)
                  .overlay(Text("day\(index + 1)"))
                  .foregroundColor(.white).bold()
                  .onTapGesture {
                      self.dailyOutfitCollectionRepo.setCurrentOutfit(index: index)
                  }
              }
          }
        }.padding(EdgeInsets(top: 36, leading: 33, bottom: 0, trailing: 0))
        Text("Outfit").padding(EdgeInsets(top: 36, leading: 33, bottom: 16, trailing: 0)).font(.system(size: 24, weight: .bold))
        Spacer()
       
        HStack {
            Text("H: \(Int(self.dailyOutfitCollectionRepo.currentOutfit.highTemp))°C")
            Text("L: \(Int(self.dailyOutfitCollectionRepo.currentOutfit.lowTemp))°C")
        }.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
          List(self.dailyOutfitCollectionRepo.currentOutfit.itemLists) { item in
          Text(item.itemTitle)
        }
//        RoundedRectangle(cornerRadius: 8)
//          .fill(Color("PrimaryOrange"))
//          .frame(width: 80, height: 40)
//          .overlay(Text("Add item")).onTapGesture {
//
//          }
      }
    }
}

struct PlanOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanOutfitsView()
    }
}
