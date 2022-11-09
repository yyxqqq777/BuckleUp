//
//  CreationStartView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationStartView: View {
    
    
    @State private var startDate = Date()
    
    var location = String()
    var userId = UUID()
    var clothesController = ClothesController()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip start?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Start Date" ,selection: $startDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                Text("Location: \(location)")
                NavigationLink(destination:CreationEndView(location:location, startDate:startDate,userId:userId,clothesController: clothesController)){
                      Text("Next Step")
                }
            }
        }.navigationBarHidden(true)
    }
}

struct CreationStartView_Previews: PreviewProvider {
    static var previews: some View {
        CreationStartView()
    }
}
