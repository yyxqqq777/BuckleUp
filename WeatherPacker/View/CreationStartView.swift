//
//  CreationStartView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationStartView: View {
    
    
    @State private var StartDate = Date()
    
    var Location = String()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip start?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Start Date" ,selection: $StartDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                Text("Location: \(Location)")
                NavigationLink(destination:CreationEndView(Location:Location, StartDate:StartDate)){
                      Text("Next Step")
                }
            }
        }
    }
}

struct CreationStartView_Previews: PreviewProvider {
    static var previews: some View {
        CreationStartView()
    }
}
