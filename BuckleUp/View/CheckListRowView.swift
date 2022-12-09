//
//  CheckListRowView.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 12/5/22.
//

import SwiftUI

struct CheckListRowView: View {
    @EnvironmentObject var packerRepository:PackerRepository
    @EnvironmentObject var editingMode: EditingMode
    @State var item: Item
    @State var quantity = ""
    @State var newTitle = ""
    
    var body: some View {
        HStack {
            if (editingMode.isEditing_Checklist[item.itemCategory]!) {
                CheckBtn(isChecked: item.isChecked, itemId: item.id, itemTitle: item.itemTitle, itemCategory: item.itemCategory)
                TextField(item.itemTitle, text: $item.itemTitle)
                    .onChange(of: item.itemTitle, perform: { newValue in
                        packerRepository.updateChecklistByTitle(title: item.itemTitle, itemId: item.id)
                    })
            } else {
                CheckBtn(isChecked: item.isChecked, itemId: item.id, itemTitle: item.itemTitle, itemCategory: item.itemCategory)
                Text(item.itemTitle)
            }
            Spacer()
            if (editingMode.isEditing_Checklist[item.itemCategory]! && item.itemCategory != "Clothes") {
                ZStack {
                    if (item.itemQuantity == 1) {
                        Circle()
                            .fill(Color("Gray"))
                            .frame(width: 24, height: 24)
                    } else {
                        Circle()
                            .fill(Color("PrimaryOrange"))
                            .frame(width: 24, height: 24)
                    }
                    Image("Subtract")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height: 16)
                }.onTapGesture {
                    print("DEBUG - Click on button -")
                    if (item.itemQuantity > 1) {
                        item.itemQuantity = item.itemQuantity - 1
                        packerRepository.updateChecklistByQuantity(isAdd: false, itemId: item.id)
                    }
                }
                Text(String(item.itemQuantity))
                //                Text(String(item.itemQuantity))
                ZStack {
                    Circle()
                        .fill(Color("PrimaryOrange"))
                        .frame(width: 24, height: 24)
                    Image("Plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height: 16)
                }.onTapGesture {
                    print("DEBUG - Click on button +")
                    item.itemQuantity = item.itemQuantity + 1
                    packerRepository.updateChecklistByQuantity(isAdd: true, itemId: item.id)
                }
            } else {
                Text(String(item.itemQuantity))
            }
        }
    }
}

struct CheckBtn: View {
  @State var isChecked: Bool
  var itemId: UUID
  var itemTitle: String
  var itemCategory:String
  @EnvironmentObject var packerRepository:PackerRepository
  @EnvironmentObject var editingMode: EditingMode
  
  var body: some View {
      if (editingMode.isEditing_Checklist[itemCategory]!) {
          if isChecked {
            ZStack {
              Circle()
                .fill(Color("PrimaryOrange"))
                .frame(width: 24, height: 24)
              Image("Done")
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
            }.onTapGesture {
              isChecked.toggle()
              packerRepository.updateItemCheckStatus(itemId: itemId, itemTitle: itemTitle, itemCategory: itemCategory)
            }
          } else {
            Circle()
              .strokeBorder(Color("Gray"), lineWidth: 2)
              .frame(width: 24, height: 24)
              .onTapGesture {
                isChecked.toggle()
                  packerRepository.updateItemCheckStatus(itemId: itemId, itemTitle: itemTitle, itemCategory: itemCategory)
              }
          }
      } else {
          if isChecked {
            ZStack {
              Circle()
                .fill(Color("PrimaryOrange"))
                .frame(width: 24, height: 24)
              Image("Done")
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
            }
          } else {
            Circle()
              .strokeBorder(Color("Gray"), lineWidth: 2)
              .frame(width: 24, height: 24)
              
          }
      }
  }
}

