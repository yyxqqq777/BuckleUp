//
//  CreationLocationView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct CreationLocationView: View {
    
    @State private var location = ""
    @State private var goToStartDate = false
    @ObservedObject var clothesController = ClothesController()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var userId = UUID()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Create Your Trip")
                    .font(.title)
                    .fontWeight(.bold)
                Form {
                    TextField("Location", text: $location)
                }
                Text("UserId:\(userId)")
                NavigationLink(destination:CreationStartView(location:location,userId:userId,clothesController: clothesController), isActive: $goToStartDate)
                {
                    Button(action:{
                        clothesController.getWeatherInfo(city: location)
                        goToStartDate = true
                    }) {
                        Text("Next Step")
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct CreationLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationLocationView()
    }
}
