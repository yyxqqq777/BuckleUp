//
//  ContentView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
        NavigationView {
          NavigationLink(destination: TripView()) {Text("trip")
          }
        }
        
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
