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
                    item.itemQuantity = item.itemQuantity - 1
                    packerRepository.updateChecklistByQuantity(isAdd: false, itemId: item.id)
                }) {
                    Text("-")
                }
                .buttonStyle(BorderlessButtonStyle())
                Text(String(item.itemQuantity))
//                Text(String(item.itemQuantity))
                Button(action:{
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
