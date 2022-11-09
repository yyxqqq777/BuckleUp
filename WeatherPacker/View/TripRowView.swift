//
//  TripRowView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

import SwiftUI

struct TripRowView: View {
    var trip: Trip
    @EnvironmentObject var listBg: ListBackground
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("\(trip.tripLocation)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            
            Text("\(trip.tripStartDate) - \(trip.tripEndDate)")
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 130)
        .listRowBackground(Image("ListBG_\(listBg.getIndex())"))
    }
}

//struct TripRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripRowView()
//    }
//}
