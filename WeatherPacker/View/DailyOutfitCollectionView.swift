//
//  DailyOutfitView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/4/22.
//

import SwiftUI

struct DailyOutfitCollectionView: View {
    
    @State var isLeftNav = false
    @State var isRightNav = false
    
    init() {
        //修改导航栏文字颜色
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        TabView {
            // Tab1:
            NavigationView {
              PlanOutfitsView()
                .navigationBarTitle(Text("New York").font(.largeTitle), displayMode: .inline)
                .navigationBarItems(leading: leftNavButton)
            }.tabItem {
              Image(uiImage: UIImage(named: "Tabbar_Cloth")!
              )
                Text("Plan Outfits").font(.subheadline)
            }
            
            // Tab2:
            NavigationView {
                ChecklistView().navigationBarTitle(Text("New York").font(.largeTitle), displayMode: .inline)
                .navigationBarItems(leading: leftNavButton)
            }.tabItem {
              Image(uiImage: UIImage(named: "Luggage")!
              )
              Text("Pack My Bag").font(.subheadline)
            }
        }
    }
    
    var leftNavButton: some View {
        Button(action: { self.isLeftNav.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("Left"))
                .padding()
        }
        .sheet(isPresented: $isLeftNav) {
            VStack {
                Text("Hello, we are QiShare!").foregroundColor(.blue).font(.system(size: 32.0))

                HStack {
                    Spacer()
                    Spacer()
                    Text("an iOS Team. ").fontWeight(.black).foregroundColor(.purple)
                    Spacer()
                    Text("We are learning SwiftUI.").foregroundColor(.blue)
                    Spacer()
                }
            }
        }
    }
    
//    var rightNavButton: some View {
//        Button(action: { self.isRightNav.toggle() }) {
//            Image(systemName: "paperplane.fill")
//                .imageScale(.large)
//                .accessibility(label: Text("Right"))
//                .padding()
//        }
//        .sheet(isPresented: $isRightNav, onDismiss: {
//            print("dissmiss RrightNav")
//        }) {
//            ZStack {
//                Text("This is the Right Navi Button.")
//            }
//        }
//    }
}

struct DailyOutfitCollectionView_Previews: PreviewProvider {
    static var previews: some View {
      DailyOutfitCollectionView()
    }
}
