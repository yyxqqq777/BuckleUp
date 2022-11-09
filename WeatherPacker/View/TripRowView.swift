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
    @State var dailyOutfitCollectionRepo = DailyOutfitCollectionRepository()
    
    var body: some View {
      //NavigationView{
        VStack {
            Spacer()
            HStack {
                Spacer()
              NavigationLink (destination: DailyOutfitCollectionView()) {
                Text("\(trip.tripLocation)")
                .onTapGesture {
                  dailyOutfitCollectionRepo.get(tripId: trip.id)
                  print("---------------DailyOutfitCollection-------\(dailyOutfitCollectionRepo)")
                }
                .font(.title2)
                .bold()
                .foregroundColor(.white)
              }
            }
               Spacer()

            Text("\(trip.tripStartDate) - \(trip.tripEndDate)")
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 130)
        .listRowBackground(Image("ListBG_\(listBg.getIndex())"))
      //}
    }
//  var body: some View {
//      NavigationLink(
//        destination:DailyOutfitCollectionView(),
//        label: {
//          Text("\(trip.tripLocation)")
//            .onTapGesture {
//              dailyOutfitCollectionRepo.get(tripId: trip.id)
//            }
//        }
//      )
//      Text("\(trip.tripStartDate)-\(trip.tripEndDate)")
//    }
    //.environmentObject(dailyOutfitCollectionRepo)
}

//struct TripRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripRowView()
//    }
//}
