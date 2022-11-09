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
    var userAuth = UserAutn()
    
    var body: some View {
        return Group {
            if signInSuccess {
                TrippView()
            } else {
                LoginView(signInSuccess: $signInSuccess)
            }
        }
        .environmentObject(tripCollectionRepository)
        .environmentObject(userAuth)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct TrippView: View {
    @EnvironmentObject var userAuth: UserAutn
    @EnvironmentObject var tripCollectionRepository:TripCollectionRepository
    
  var body: some View {
      NavigationView {
          VStack {
            Text("Trip List").padding(12).font(Font.headline.weight(.bold))
              List {
                  ForEach(tripCollectionRepository.trips) { trip in
                      TripRowView(trip: trip)
                  }
              }.background(.white)
              NavigationLink(destination:CreationView()) {
                  Text("Create New Trip")
                      .frame(maxWidth: .infinity, maxHeight: 40)
                      .font(.title3.bold())
                      .foregroundColor(.white)
                      .background(Color("PrimaryOrange"))
                      .cornerRadius(20)
              }
          }
      }
  }
}

struct LoginView: View {
    
    @Binding var signInSuccess:Bool
    
    @EnvironmentObject var userAuth: UserAutn
    @EnvironmentObject var tripCollectionRepository:TripCollectionRepository
    
    @State var userName = ""
    @State var pwd = ""
    
    @ObservedObject var userRepository = UserRepository()
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    TextField("User Name", text: $userName)
                    TextField("Password", text: $pwd)
                }
                Button(action: {
                    if userRepository.verify(userName: userName, pwd: pwd) {
                        self.userAuth.userId = userRepository.getUserId(userName: userName)
                        self.tripCollectionRepository.getById(userId:userAuth.userId.uuidString)
                        self.signInSuccess = true
                    }
                }) {
                    Text("Login")
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
    
    @EnvironmentObject var userAuth:UserAutn
    //@EnvironmentObject var tripRepository:TripCollectionRepository
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Create Your Trip")
                    .font(.title)
                    .fontWeight(.bold)
                Form {
                    TextField("Location", text: $location)
                }
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
                }
            }
        }//.navigationBarHidden(true)
    }
}

struct TripStartView: View {
    
    @Binding var rootIsActive : Bool
    @State private var startDate = Date()
    @EnvironmentObject var userAuth:UserAutn
    
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
    @EnvironmentObject var userAuth:UserAutn
    @EnvironmentObject var tripCollectionReposiroty:TripCollectionRepository
    
    var location = String()
    var startDate = Date()
    var clothesController = ClothesController()
    
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
            Button(action:{
                var tripId = tripController.update(userId: userAuth.userId, location: location, startDate: startDate, endDate: endDate, tripRepo: tripCollectionReposiroty)
                clothesController.calculate_date(startDate: startDate, endDate: endDate)
                clothesController.generateOutfit()
                clothesController.createOutfit(tripId: tripId, location: location)
                self.shouldPopToRootView = false
            }){
                Text("Create Trip")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(20)
            }
        }.navigationBarHidden(true)
    }
}

