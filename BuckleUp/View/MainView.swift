//
//  MainView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/6/22.
//

import SwiftUI

struct MainView: View {
    @State var signInSuccess = false
    @State var userId = UUID()
    var tripCollectionRepository = TripCollectionRepository()
    var userAuth = UserAuth()
    var listBg = ListBackground()
    
    var body: some View {
        return Group {
            if signInSuccess {
                TripView(signInSuccess: $signInSuccess)
            } else {
                LoginView(signInSuccess: $signInSuccess)
            }
        }
        .environmentObject(tripCollectionRepository)
        .environmentObject(userAuth)
        .environmentObject(listBg)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct TripView: View {
    @Binding var signInSuccess:Bool
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var tripCollectionRepository:TripCollectionRepository
    @EnvironmentObject var listBg: ListBackground
    
    var body: some View {
        NavigationView{
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Coming Trips").font(.title2).bold()
                            Spacer()
                        }
                        VStack {
                            if tripCollectionRepository.tripsNotExpired.count > 0 {
                                ForEach(tripCollectionRepository.tripsNotExpired) { trip in
                                    TripRowView(trip: trip)
                                }
                            } else {
                                Image("NoTrip")
                                    .resizable()
                                    .frame(width: 360, height: 300)
                            }
                            
                        }
                        Divider().frame(minHeight: 8).foregroundColor(Color("Gray")).bold()
                        HStack {
                            Text("Past Trips").font(.title2).bold()
                            Spacer()
                        }
                        if tripCollectionRepository.tripsExpired.count > 0 {
                            VStack {
                                ForEach(tripCollectionRepository.tripsExpired) { trip in
                                    TripRowView(trip: trip)
                                }
                            }
                        }else {
                            Image("NoTrip")
                                .resizable()
                                .frame(width: 360, height: 300)
                        }
                    }.padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
                }
                
                NavigationLink(
                    destination: CreationView()
                ) {
                    Text("Create New Trip")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .background(Color("PrimaryOrange"))
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .background(Color.white)
            .navigationBarTitle("Trips", displayMode: .inline)
            .toolbarBackground(Color("PrimaryOrange"),
                               for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image("Logout")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                self.signInSuccess = false
                            }
                    }
                }
            }
        }
    }
}

struct CreationView: View {
    @State var isActive = false
    @State private var location = ""
    @State private var goToStartDate = false

    @ObservedObject var clothesController = ClothesController()

    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var listBg:ListBackground

    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    Text("Create Your Trip")
                        .font(.title)
                        .fontWeight(.bold)
                    Form {
                        TextField("Location", text: $location)
                    }.scrollContentBackground(.hidden)
                    
                    Image("Creation").resizable().frame(width:350 ,height:210)
                    NavigationLink(
                        destination:TripStartView(
                            rootIsActive: self.$isActive,
                            location: location,
                            clothesController: clothesController),
                        isActive: self.$isActive)
                    {
                        Text("Next Step")
                            .onTapGesture {
                                clothesController.getWeatherInfo(city: location)
                                self.isActive = true
                            }
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .background(Color("PrimaryOrange"))
                            .cornerRadius(20)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
            }
        }
    }
}

struct TripStartView: View {
    
    @Binding var rootIsActive : Bool
    @State private var startDate = Date()
    @EnvironmentObject var userAuth:UserAuth
    
    var location = String()
    var clothesController = ClothesController()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When does your trip start?")
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    in:Date()...Date().addingTimeInterval(529200),
                    displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(Color("PrimaryOrange"))
                Spacer()
                Image("Creation").resizable().frame(width:350 ,height:210)
                NavigationLink(
                    destination:TripEndView(
                        shouldPopToRootView: self.$rootIsActive,
                        location: location,
                        startDate: startDate,
                        clothesController: clothesController)){
                            Text("Next Step")
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .background(Color("PrimaryOrange"))
                                .cornerRadius(20)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        }
            }
        }.navigationBarHidden(true)
    }
}

struct TripEndView: View {
    
    @Binding var shouldPopToRootView:Bool
    
    @State private var endDate = Date()
    @State private var goToTripView = false
    @ObservedObject var tripController = TripController()
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var tripCollectionReposiroty:TripCollectionRepository
    @EnvironmentObject var listBG: ListBackground
    
    var location = String()
    var startDate = Date()
    var clothesController = ClothesController()
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Text("When does your trip end?")
                .font(.title)
                .fontWeight(.bold)
            DatePicker(
                "Start Date",
                selection: $endDate,
                in:Date()...Date().addingTimeInterval(529200),
                displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .accentColor(Color("PrimaryOrange"))
            Spacer()
            Image("Creation").resizable().frame(width:350 ,height:210)
            Button(action:{
                var tripId = tripController.update(userId: userAuth.userId, location: location, startDate: startDate, endDate: endDate, tripRepo: tripCollectionReposiroty)
                clothesController.calculate_date(startDate: startDate, endDate: endDate)
                clothesController.generatePacker()
                clothesController.createPacker(tripId: tripId, location: location)
                listBG.bgIndex = 0
                self.shouldPopToRootView = false
                self.showAlert = true
            }){
                Text("Create Trip")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }.alert("Trip created", isPresented: $showAlert, actions: {
                Button("Confirm", action: {
                    self.showAlert = false
                })
              }, message: {
                  Text("Please go back to the trip")
              })
        }.navigationBarHidden(true)
    }
}
