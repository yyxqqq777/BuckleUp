//
//  UserInfo.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

import Foundation
class UserAutn: ObservableObject {
    @Published var userId:UUID
    
    init(){
        userId = UUID()
    }
    
}
