//
//  DailyOutfitView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import SwiftUI

struct PackerView: View {
    
    @State var isLeftNav = false
    @State var isRightNav = false
    var tripLocation = String()
    var tripId = UUID()
    var tripStartDate = String()
    var packerRepository = PackerRepository()
    
    var body: some View {
        TabView {
            // Plan Outfits Tab:
            NavigationView {
                PlanOutfitsView(startDateString: tripStartDate)
                    .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
            }.tabItem {
                Image(uiImage: UIImage(named: "Tabbar_Cloth")!
                )
                Text("Plan Outfits").font(.subheadline)
            }
            
            // checklist Tab:
            NavigationView {
                ChecklistView()
                    .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
            }.tabItem {
                Image(uiImage: UIImage(named: "Luggage")!
                )
                Text("Pack My Bag").font(.subheadline)
            }
        }
        .navigationBarTitle(Text("\(tripLocation)").font(.title).foregroundColor(.white))
        .toolbarBackground(Color("PrimaryOrange"),
                           for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear(perform: {
            packerRepository.reclear()
            packerRepository.get(tripId: tripId)
        })
        .environmentObject(packerRepository)
        .accentColor(Color("PrimaryOrange"))
    }
}

struct DailyOutfitCollectionView_Previews: PreviewProvider {
    static var previews: some View {
      PackerView()
    }
}
