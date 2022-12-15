//
//  ListBackground.swift
//  WeatherPacker
//
//  Created by 薛渤凡 on 11/9/22.
//

import Foundation
class ListBackground: ObservableObject {
    var bgIndex: Int

    init(){
        self.bgIndex = 0
    }

    func getIndex() -> Int {
        self.bgIndex = self.bgIndex + 1
        return self.bgIndex % 8
    }
}
