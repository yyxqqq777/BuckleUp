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
                CheckBtn(isChecked: item.isChecked, itemId: item.id)
                TextField(item.itemTitle, text: $item.itemTitle)
                    .onChange(of: item.itemTitle, perform: { newValue in
                  packerRepository.updateChecklistByTitle(title: item.itemTitle, itemId: item.id)
                })
            } else {
                Text(item.itemTitle)
            }
            Spacer()
            if (editingMode.isEditing_Checklist[item.itemCategory]!) {
                
                Button(action:{
                  print("DEBUG - Click on button -")
                    item.itemQuantity = item.itemQuantity - 1
                    packerRepository.updateChecklistByQuantity(isAdd: false, itemId: item.id)
                }) {
                    Text("-")
                }
                .buttonStyle(BorderlessButtonStyle())
                Text(String(item.itemQuantity))
//                Text(String(item.itemQuantity))
                Button(action:{
                  print("DEBUG - Click on button +")
                    item.itemQuantity = item.itemQuantity + 1
                    packerRepository.updateChecklistByQuantity(isAdd: true, itemId: item.id)
                }) {
                    Text("+")
                }
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Text(String(item.itemQuantity))
            }
        }
    }
}

struct CheckBtn: View {
  @State var isChecked: Bool
  @State var itemId: UUID
  @EnvironmentObject var packerRepository:PackerRepository
  
  var body: some View {
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
        packerRepository.updateItemCheckStatueById(itemId: itemId)
      }
    } else {
      Circle()
        .strokeBorder(Color("Gray"), lineWidth: 2)
        .frame(width: 24, height: 24)
        .onTapGesture {
          isChecked.toggle()
          packerRepository.updateItemCheckStatueById(itemId: itemId)
        }
    }
  }
}

