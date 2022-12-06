//
//  EditingMode.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 12/4/22.
//

import Foundation
class EditingMode: ObservableObject {
  @Published var isEditing: Bool
  @Published var btnName: String
    @Published var isEditing_Toiletries: Bool
    @Published var btnName_Toiletries: String
    @Published var isEditing_Electronics: Bool
    @Published var btnName_Electronics: String
    @Published var isEditing_Accessories: Bool
    @Published var btnName_Accessories: String
    @Published var isEditing_Checklist: [String:Bool]
  
  init(){
    isEditing = false
    btnName = "Edit"
      isEditing_Toiletries = false
      btnName_Toiletries = "Edit"
      isEditing_Electronics = false
      btnName_Electronics = "Edit"
      isEditing_Accessories = false
      btnName_Accessories = "Edit"
      isEditing_Checklist = ["Toiletries":false, "Electronics":false, "Accessories": false]
  }
  
  func setEdit() {
    btnName = "Edit"
  }
    
    func setEditToiletries() {
      btnName_Toiletries = "Edit"
    }
    
    func setEditElectronics() {
      btnName_Electronics = "Edit"
    }
    
    func setEditAccessories() {
      btnName_Accessories = "Edit"
    }
  
  func setDone() {
    btnName = "Done"
  }
    
    func setDoneToiletries() {
      btnName_Toiletries = "Done"
    }
    
    func setDoneElectronics() {
      btnName_Electronics = "Done"
    }
    
    func setDoneAccessories() {
      btnName_Accessories = "Done"
    }

}
