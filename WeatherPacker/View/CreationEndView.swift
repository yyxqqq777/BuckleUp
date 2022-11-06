//
//  CreationEndView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationEndView: View {
    
    @State private var EndDate = Date()
    
    let datefmt = DateFormatter()
    var Location = String()
    var StartDate = Date()
    
    func format(){
        datefmt.dateFormat = "yyyy-MM-dd"
        datefmt.string(from: EndDate)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip end?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Start Date" ,selection: $EndDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                Text("StartDate: \(StartDate)")
                Text("EndDate: \(EndDate)")
                Button( action: {
                    format()
                    print(datefmt)
                } ){
                    Text("Formatting")
                }
                Text("Formatting: \(datefmt)")
//                NavigationLink(destination:CreationEndView(Location:Location, StartDate:StartDate)){
//                      Text("Next Step")
//                }
            }
        }
    }
}

struct CreationEndView_Previews: PreviewProvider {
    static var previews: some View {
        CreationEndView()
    }
}
