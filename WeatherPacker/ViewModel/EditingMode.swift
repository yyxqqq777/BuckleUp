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
  
  init(){
    isEditing = false
    btnName = "Edit"
  }
  
  func setEdit() {
    btnName = "Edit"
  }
  
  func setDone() {
    btnName = "Done"
  }
}
