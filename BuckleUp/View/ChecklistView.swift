//
//  ChecklistView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 11/9/22.
//

import SwiftUI

struct ChecklistView: View {
    @EnvironmentObject var packerRepository:PackerRepository
    var editingMode = EditingMode()
    
    @State var isEditing_Clothes = false
    @State var isEditing_Toiletries = false
    @State var isEditing_Electronics = false
    @State var isEditing_Accessories = false
    
    @State var newItemTitle_Toiletries = ""
    @State var newItemTitle_Electronics = ""
    @State var newItemTitle_Accessories = ""
    
    @State var presentAlert_Toiletries = false
    @State var presentAlert_Electronics = false
    @State var presentAlert_Accessories = false
    
    
    var buttonLabel_Clothes: String {
        // Compute the label based on button state
        isEditing_Clothes ? "Done" : "Edit"
    }
    
    var buttonLabel_Toiletries: String {
        // Compute the label based on button state
        isEditing_Toiletries ? "Done" : "Edit"
    }
    
    var buttonLabel_Electronics: String {
        // Compute the label based on button state
        isEditing_Electronics ? "Done" : "Edit"
    }
    
    var buttonLabel_Accessories: String {
        // Compute the label based on button state
        isEditing_Accessories ? "Done" : "Edit"
    }
    
    var body: some View {
        
        ScrollView {
            //——————————————cloth category
            VStack {
                HStack {
                    Text("Clothes")
                        .font(.title3).bold()
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 0))
                    Spacer()
                    
                    Button(action:{
                        if (!isEditing_Clothes) {
                            isEditing_Clothes = true
                            editingMode.isEditing_Checklist["Clothes"] = true
                        }
                        else {
                            isEditing_Clothes = false
                            editingMode.isEditing_Checklist["Clothes"] = false
                            packerRepository.saveUpdatePacker()
                        }}, label: {
                            Text(buttonLabel_Clothes)
                                .foregroundColor(.white)
                        })
                    .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(8)
                    .frame(width: 85)
                }
                
                if (!isEditing_Clothes) {
                    List {
                        ForEach(packerRepository.aggregatedClothes) { item in
                            CheckListRowView(item:item)
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List {
                        ForEach(packerRepository.aggregatedClothes) { item in
                            CheckListRowView(item:item)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(height: 200)
            Rectangle()
                .fill(Color("SystemGray"))
                .frame(width: .infinity, height: 20)
            //_________________Toiletries category
            VStack {
                HStack {
                    Text("Toiletries")
                        .font(.title3).bold()
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 0))
                    Spacer()
                    if(!isEditing_Toiletries) {
                        
                    } else {
                        Button("✚Add Item") {
                            presentAlert_Toiletries = true
                        }
                        .alert("New Item", isPresented: $presentAlert_Toiletries, actions: {
                            TextField("Please type the item", text: $newItemTitle_Toiletries)
                            Button("Add", action: {packerRepository.addNewItemFromChecklist(title: newItemTitle_Toiletries, category: "Toiletries")})
                            Button("Cancel", role: .cancel, action: {})
                        }, message: {
                        })
                    }
                    
                    Button(action:{
                        if (!isEditing_Toiletries) {
                            isEditing_Toiletries = true
                            editingMode.isEditing_Checklist["Toiletries"] = true
                        }
                        else {
                            isEditing_Toiletries = false
                            editingMode.isEditing_Checklist["Toiletries"] = false
                            packerRepository.saveUpdatePacker()
                        }}, label: {
                            // DECLARE what you want to see
                            Text(buttonLabel_Toiletries)
                                .foregroundColor(.white)
                        })
                    .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(8)
                    .frame(width: 85)
                }
                
                if (!isEditing_Toiletries) {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists) { item in
                            if(item.itemCategory == "Toiletries") {
                                CheckListRowView(item:item)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists, id: \.self) {item in
                            if(item.itemCategory == "Toiletries") {
                                CheckListRowView(item:item)
                            }
                        }.onDelete{ indexSet in
                            packerRepository.deleteItemFromChecklist(itemId: indexSet)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(height: 200)
            Rectangle()
                .fill(Color("SystemGray"))
                .frame(width: .infinity, height: 20)
            
            //_________Electronics category
            VStack {
                HStack {
                    Text("Electronics")
                        .font(.title3).bold()
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 0))
                    Spacer()
                    if(!isEditing_Electronics) {
                        
                    } else {
                        Button("✚Add Item") {
                            presentAlert_Electronics = true
                        }
                        .alert("New Item", isPresented: $presentAlert_Electronics, actions: {
                            TextField("Please type the item", text: $newItemTitle_Toiletries)
                            Button("Add", action: {packerRepository.addNewItemFromChecklist(title: newItemTitle_Toiletries, category: "Electronics")})
                            Button("Cancel", role: .cancel, action: {})
                        }, message: {
                        })
                    }
                    
                    Button(action:{
                        if (!isEditing_Electronics) {
                            isEditing_Electronics = true
                            editingMode.isEditing_Checklist["Electronics"] = true
                        }
                        else {
                            isEditing_Electronics = false
                            editingMode.isEditing_Checklist["Electronics"] = false
                            packerRepository.saveUpdatePacker()
                        }}, label: {
                            // DECLARE what you want to see
                            Text(buttonLabel_Electronics)
                                .foregroundColor(.white)
                        })
                    .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(8)
                    .frame(width: 85)
                }
                
                if (!isEditing_Electronics) {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists) { item in
                            if(item.itemCategory == "Electronics") {
                                CheckListRowView(item:item)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists, id: \.self) {item in
                            if(item.itemCategory == "Electronics") {
                                CheckListRowView(item:item)
                            }
                        }.onDelete{ indexSet in
                            packerRepository.deleteItemFromChecklist(itemId: indexSet)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(height: 200)
            Rectangle()
                .fill(Color("SystemGray"))
                .frame(width: .infinity, height: 20)
            //____________Accessories category
            VStack {
                HStack {
                    Text("Accessories")
                        .font(.title3).bold()
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 0))
                    Spacer()
                    if(!isEditing_Accessories) {
                        
                    } else {
                        Button("✚Add Item") {
                            presentAlert_Accessories = true
                        }
                        .alert("New Item", isPresented: $presentAlert_Accessories, actions: {
                            TextField("Please type the item", text: $newItemTitle_Toiletries)
                            Button("Add", action: {packerRepository.addNewItemFromChecklist(title: newItemTitle_Toiletries, category: "Accessories")})
                            Button("Cancel", role: .cancel, action: {})
                        }, message: {
                        })
                    }
                    
                    Button(action:{
                        if (!isEditing_Accessories) {
                            isEditing_Accessories = true
                            editingMode.isEditing_Checklist["Accessories"] = true
                        }
                        else {
                            isEditing_Accessories = false
                            editingMode.isEditing_Checklist["Accessories"] = false
                            packerRepository.saveUpdatePacker()
                        }}, label: {
                            // DECLARE what you want to see
                            Text(buttonLabel_Accessories)
                                .foregroundColor(.white)
                        })
                    .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                    .background(Color("PrimaryOrange"))
                    .cornerRadius(8)
                    .frame(width: 85)
                }
                
                if (!isEditing_Accessories) {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists) { item in
                            if(item.itemCategory == "Accessories") {
                                CheckListRowView(item:item)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List {
                        ForEach(packerRepository.checklistPacker.itemLists, id: \.self) {item in
                            if(item.itemCategory == "Accessories") {
                                CheckListRowView(item:item)
                            }
                        }.onDelete{ indexSet in
                            packerRepository.deleteItemFromChecklist(itemId: indexSet)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(height: 200)
        }
        .environmentObject(packerRepository)
        .environmentObject(editingMode)
    }
}

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
