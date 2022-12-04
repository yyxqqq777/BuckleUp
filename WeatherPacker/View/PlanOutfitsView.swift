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
          
        Spacer()
       
          HStack {
              VStack {
                  Text(showWeatherResult(weathercode: self.packerRepository.currentDailyPacker.weatherCode))
                  .font(.title2).bold()
                      //.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
                  HStack {
                      Text("H: \(Int(self.packerRepository.currentDailyPacker.highTemp))°C")
                      Text("L: \(Int(self.packerRepository.currentDailyPacker.lowTemp))°C")
                  }//.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
              }.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
              Spacer()
              Image(showWeatherResult(weathercode: self.packerRepository.currentDailyPacker.weatherCode))
                  .frame(width: 32, height: 32)
                  .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
          }
          
          Text("Outfit").padding(EdgeInsets(top: 12, leading: 33, bottom: 16, trailing: 0)).font(.system(size: 24, weight: .bold))
          List(self.packerRepository.currentDailyPacker.itemLists) { item in
              HStack {
                  Image(chooseIcon(subCategory: item.subCategory))
                      .resizable()
                      .frame(width: 24, height: 24)
                      .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 6))
                  Text(item.itemTitle)
              }
          }.scrollContentBackground(.hidden)
//        RoundedRectangle(cornerRadius: 8)
//          .fill(Color("PrimaryOrange"))
//          .frame(width: 80, height: 40)
//          .overlay(Text("Add item")).onTapGesture {
//
//          }
      }.background(Color.white)
      
    }
    
    func showWeatherResult(weathercode: String) -> String {
        switch(weathercode) {
        case "0" :
            return "Clear Sky"
        case "1","2","3":
            return "Partly Cloudy"
        case "45","48":
            return "Fog"
        case "51","53","55":
            return "Drizzle"
        case "56","57":
            return "Freezing Drizzle"
        case "61","63","65":
            return "Rain"
        case "66","67":
            return "Freezing Rain"
        case "71","73","75":
            return "Snow"
        case "77":
            return "Snow Grains"
        case "80","81","82":
            return "Rain Showers"
        case "85","86":
            return "Snow Showers"
        case "95","96","99":
            return "Thunderstorms"
        default:
            return "Clear Sky"
        }
    }
    
    func chooseIcon(subCategory: String) -> String {
        switch(subCategory) {
        case "Beanie" :
            return "Beanie"
        case "Coat":
            return "Coat"
        case "Hoodie":
            return "Hoodie"
        case "Jacket":
            return "Jacket"
        case "Jeans":
            return "Jeans"
        case "Long-Sleeves":
            return "Long-Sleeves"
        case "Mittens":
            return "Mittens"
        case "Shoes":
            return "Shoes"
        case "Shorts":
            return "Shorts"
        case "Socks":
            return "Socks"
        case "Sunglasses":
            return "Sunglasses"
        case "Sweater":
            return "Sweater"
        case "T-Shirt":
            return "T-Shirt"
        case "Umbrella":
            return "Umbrella"
        case "Underwear":
            return "Underwear"
        default:
            return "Customized"
        }
    }
    
}

struct PlanOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanOutfitsView()
    }
}
