//
//  PlanOutfitsView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/8/22.
//

import SwiftUI

struct PlanOutfitsView: View {
  @EnvironmentObject var packerRepository:PackerRepository

    var body: some View {
        let dailyPackers = self.packerRepository.dailyPackers
        let currentDailyPacker = self.packerRepository.currentDailyPacker
      
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(0..<dailyPackers.count, id: \.self) { index in
              RoundedRectangle(cornerRadius: 8)
                .fill(Color("PrimaryOrange"))
                .frame(width: 80, height: 30)
                .overlay(Text("Day \(index + 1)"))
                .foregroundColor(.white).bold()
                .onTapGesture {
                    self.packerRepository.setCurrentDailyPacker(index: index)
                }
            }
          }
        }.padding(EdgeInsets(top: 12, leading: 33, bottom: 0, trailing: 0))
        Text("Outfit").padding(EdgeInsets(top: 36, leading: 33, bottom: 16, trailing: 0)).font(.system(size: 24, weight: .bold))
        Spacer()
       
        HStack {
            Text("H: \(Int(self.packerRepository.currentDailyPacker.highTemp))°C")
            Text("L: \(Int(self.packerRepository.currentDailyPacker.lowTemp))°C")
        }.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
          List(self.packerRepository.currentDailyPacker.itemLists) { item in
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
