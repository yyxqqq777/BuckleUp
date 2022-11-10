//
//  UserInfo.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

import Foundation
class UserAuth: ObservableObject {
    @Published var userId:UUID
    
    init(){
        userId = UUID()
    }
    
}
