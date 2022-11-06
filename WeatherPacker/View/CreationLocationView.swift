//
//  CreationLocationView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationLocationView: View {
    
    @State private var Location = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Create Your Trip")
                    .font(.title)
                    .fontWeight(.bold)
                Form {
                    TextField("Location", text: $Location)
                }
                NavigationLink(destination:CreationStartView(Location:Location)){
                      Text("Next Step")
//                      Button("Next Step") {
//                  }
                }
            }
        }
    }
}

struct CreationLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationLocationView()
    }
}
