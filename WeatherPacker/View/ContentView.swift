//
//  ContentView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Tap any link below to see the data pull from Firebase")
        NavigationLink(destination: UserView()) {Text("User")
        }.padding()
        NavigationLink(destination: ListView()) {Text("List")
        }.padding()
        NavigationLink(destination: TripView()) {Text("Trip")
        }.padding()
        NavigationLink(destination: ItemView()) {Text("Item")
        }.padding()
        NavigationLink(destination: ClothesView()) {Text("Clothes")
        }.padding()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
