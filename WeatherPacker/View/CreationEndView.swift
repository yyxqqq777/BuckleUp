//
//  CreationEndView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationEndView: View {
    
    @State private var EndDate = Date()
    
    var Location = String()
    var StartDate = Date()
    var userId = String()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip end?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Start Date" ,selection: $EndDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                Text("StartDate: \(StartDate)")
                Text("EndDate: \(EndDate)")
                NavigationLink(destination:TripView()){
                      Text("Create Trip")
                }
            }
        }
    }
    
    func create() {
        var tripController = TripController()
//        tripController.update(userId: UUID.init(uuidString: userId), location: Location, startDate: StartDate, endDate: EndDate)
    }
}

struct CreationEndView_Previews: PreviewProvider {
    static var previews: some View {
        CreationEndView()
    }
}
