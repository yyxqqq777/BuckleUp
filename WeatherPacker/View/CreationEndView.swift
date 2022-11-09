//
//  CreationEndView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationEndView: View {
    
    @State private var endDate = Date()
    @State private var goToTripView = false
    @ObservedObject var tripController = TripController()
    
    var location = String()
    var startDate = Date()
    var userId = UUID()
    var clothesController = ClothesController()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip end?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Start Date" ,selection: $endDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                Text("StartDate: \(location)")
                Text("StartDate: \(startDate)")
                Text("EndDate: \(endDate)")
                NavigationLink(destination:TripView(), isActive: $goToTripView){
//                    Button(action:{
//                        var tripId = tripController.update(userId: userId, location: location, startDate: startDate, endDate: endDate)
//                        clothesController.calculate_date(startDate: startDate, endDate: endDate)
//                        clothesController.generateOutfit()
//                        clothesController.createOutfit(tripId: tripId, location: location)
//                        goToTripView = true
//                    }){
//                        Text("Create Trip")
//                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct CreationEndView_Previews: PreviewProvider {
    static var previews: some View {
        CreationEndView()
    }
}
