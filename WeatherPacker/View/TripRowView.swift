//
//  TripRowView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

import SwiftUI

struct TripRowView: View {
    var trip : Trip
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
        .frame(width: .infinity, height: 140)
        .listRowBackground(Color("PrimaryOrange"))
    }
}

//struct TripRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripRowView()
//    }
//}
