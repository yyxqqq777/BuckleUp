//
//  DailyPackerItemView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 12/4/22.
//

import SwiftUI

struct DailyPackerItemView: View {
    @State var item: Item
    @EnvironmentObject var packerRepository:PackerRepository
    @EnvironmentObject var editingMode: EditingMode
    
    var body: some View {
        HStack {
            Image(chooseIcon(subCategory: item.subCategory))
                .resizable()
                .frame(width: 24, height: 24)
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 6))
            if (editingMode.isEditing) {
                TextField(item.itemTitle, text: $item.itemTitle).onChange(of: item.itemTitle, perform: { newValue in
                    packerRepository.updateCloth(title: item.itemTitle, itemId: item.id)
                })
            } else {
                Text(item.itemTitle)
            }
        }
    }
    
    
    func chooseIcon(subCategory: String) -> String {
        switch(subCategory) {
        case "Baenie" :
            return "Baenie"
        case "Coat":
            return "Coat"
        case "Hoodie":
            return "Hoodie"
        case "Jacket":
            return "Jacket"
        case "Jeans":
            return "Jeans"
        case "Long-Sleeves":
            return "Long-Sleeves"
        case "Mittens":
            return "Mittens"
        case "Shoes":
            return "Shoes"
        case "Shorts":
            return "Shorts"
        case "Socks":
            return "Socks"
        case "Sunglasses":
            return "Sunglasses"
        case "Sweater":
            return "Sweater"
        case "T-Shirt":
            return "T-Shirt"
        case "Umbrella":
            return "Umbrella"
        case "Underwear":
            return "Underwear"
        default:
            return "Customized"
        }
    }
}

