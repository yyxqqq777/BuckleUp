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
    @State var packerRepository = PackerRepository()
    @State var tripController = TripController()
    @State var progress = Double.random(in: 0..<1)

    var body: some View {
        NavigationLink(destination: PackerView(tripLocation: trip.tripLocation, tripId: trip.id, tripStartDate: trip.tripStartDate)) {
            ZStack {
                Image("ListBG_\(listBg.getIndex())")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 200, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.15)).frame(width: 350, height: 200))
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(trip.tripLocation)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        Text("\(tripController.calculateDateDot(startDateString: trip.tripStartDate)) - \(tripController.calculateDateDot(startDateString: trip.tripEndDate))")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 120))
                }
            }
        }
    }
}
