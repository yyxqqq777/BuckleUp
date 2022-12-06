//
//  PlanOutfitsView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/8/22.
//

import SwiftUI

struct PlanOutfitsView: View {
    var startDateString = String()
    @EnvironmentObject var packerRepository:PackerRepository
    @State var isEditing = false
    @State private var presentAlert = false
    @State var newItemTitle = ""
    var editingMode = EditingMode()
    var tripController = TripController()
    
    var buttonLabel: String {
      // Compute the label based on button state
      isEditing ? "Done" : "Edit"
    }

    var body: some View {
      VStack(alignment: .leading) {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
              ForEach(0..<self.packerRepository.dailyPackers.count, id: \.self) { index in
              RoundedRectangle(cornerRadius: 8)
                .fill(Color("PrimaryOrange"))
                .frame(width: 100, height: 60)
                .overlay(
                    VStack {
                        Text("Day \(index + 1)")
                        Text(self.tripController.calculateDate(startDateString: startDateString, index: index))
                    }
                )
                .foregroundColor(.white).bold()
                .onTapGesture {
                  self.packerRepository.setCurrentDailyPacker(index: index)
                }
            }
          }
        }.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
        
        Spacer()
        
        HStack {
            VStack(alignment: .leading) {
            Text(showWeatherResult(weathercode: self.packerRepository.currentDailyPacker.weatherCode))
              .font(.title2).bold()
              .frame(alignment: .leading)
            HStack {
              Text("H: \(Int(self.packerRepository.currentDailyPacker.highTemp))°C")
              Text("L: \(Int(self.packerRepository.currentDailyPacker.lowTemp))°C")
            }//.padding(EdgeInsets(top: 0, leading: 33, bottom: 0, trailing: 0))
          }.padding(EdgeInsets(top: 12, leading: 33, bottom: 0, trailing: 0))
          Spacer()
          Image(showWeatherResult(weathercode: self.packerRepository.currentDailyPacker.weatherCode))
            .frame(width: 32, height: 32)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
        }
        
        HStack {
          Text("Outfit").padding(EdgeInsets(top: 12, leading: 33, bottom: 16, trailing: 0))
            .font(.system(size: 24, weight: .bold))
          Spacer()
          Button(action:{
            if (!isEditing) {
              isEditing = true
              editingMode.isEditing = true
            }
            else {
              isEditing = false
              editingMode.isEditing = false
              packerRepository.saveUpdatePacker()
            }}, label: {
              // DECLARE what you want to see
              Text(buttonLabel)
            })
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
        }
        
        if (!isEditing) {
          List {
            ForEach(packerRepository.currentDailyPacker.itemLists) {
              item in
                if (item.itemCategory == "Clothes" || item.itemCategory == "Accessories") {
                    DailyPackerItemView(item: item)
                }
            }
          }.scrollContentBackground(.hidden)
        } else {
          List {
            ForEach(packerRepository.currentDailyPacker.itemLists, id: \.self) {
              item in
                if (item.itemCategory == "Clothes" || item.itemCategory == "Accessories") {
                    DailyPackerItemView(item: item)
                }
            }.onDelete{ indexSet in
              packerRepository.deleteItem(itemId: indexSet)
            }
          }.scrollContentBackground(.hidden)
        }
        
        if (!isEditing) {
          
        } else {
          Button("Add Item") {
            presentAlert = true
          }
          .alert("New Item", isPresented: $presentAlert, actions: {
            TextField("Please type the item", text: $newItemTitle)
            Button("Add", action: {packerRepository.addNewItem(title: newItemTitle)})
            Button("Cancel", role: .cancel, action: {})
          }, message: {
            // Any view other than Text would be ignored
          })
          //          RoundedRectangle(cornerRadius: 8)
          //            .fill(Color("PrimaryOrange"))
          //            .frame(width: 80, height: 40)
          //            .overlay(Text("Add item")).onTapGesture {
          //              DailyPackerItemView(item: Item(id: UUID(), itemTitle: "", itemCategory: "Clothes", subCategory: "Customized", isChecked: false, itemQuantity:1))
          //            }
        }
        
      }.background(Color.white)
      .environmentObject(packerRepository)
      .environmentObject(editingMode)
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
    
}

struct PlanOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanOutfitsView()
    }
}

