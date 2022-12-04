//
//  ChecklistView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/9/22.
//

import SwiftUI

struct ChecklistView: View {
  @EnvironmentObject var packerRepository:PackerRepository
    
    var body: some View {
        
        VStack {
            //ScrollView {
                VStack {
                    Text("Clothes").font(.title3).bold()
                    List(self.packerRepository.itemsClothes) { item in
                        HStack {
                            Text(item.itemTitle)
                            Spacer()
                            Text(String(item.itemQuantity))
                        }
                    }
                    Text("Toiletries").font(.title3).bold()
                    List(self.packerRepository.itemsToiletries) { item in
                        HStack {
                            Text(item.itemTitle)
                            Spacer()
                            Text(String(item.itemQuantity))
                        }
                    }
                    Text("Electronics").font(.title3).bold()
                    List(self.packerRepository.itemsElectronics) { item in
                        HStack {
                            Text(item.itemTitle)
                            Spacer()
                            Text(String(item.itemQuantity))
                        }
                    }
                    Text("Accessories").font(.title3).bold()
                    List(self.packerRepository.itemsAccessories) { item in
                        HStack {
                            Text(item.itemTitle)
                            Spacer()
                            Text(String(item.itemQuantity))
                        }
                    }
                //}
            }
        }
        
            
        
//        ScrollView {
//            VStack {
//                Text("Clothes").font(.title3).bold()
//                List(self.packerRepository.itemsClothes) { item in
//                    HStack {
//                        Text(item.itemTitle)
//                        Spacer()
//                        Text(String(item.itemQuantity))
//                    }
//                }
//                Text("Accessories").font(.title2).bold()
//                List(itemsAccessories) { item in
//                    HStack {
//                        Text(item.itemTitle)
//                        Spacer()
//                        Text(String(item.itemQuantity))
//                    }
//                }
//                Text("Toiletries").font(.title3).bold()
//                List(itemsToiletries) { item in
//                    HStack {
//                        Text(item.itemTitle)
//                        Spacer()
//                        Text(String(item.itemQuantity))
//                    }
//                }
//                Text("Electronics").font(.title3).bold()
//                List(itemsElectronics) { item in
//                    HStack {
//                        Text(item.itemTitle)
//                        Spacer()
//                        Text(String(item.itemQuantity))
//                    }
//                }
//
//            }
//        }
    }
}

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
