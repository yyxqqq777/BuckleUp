//
//  CircleProgressView.swift
//  WeatherPacker
//
//  Created by Yunxuan Yu on 12/7/22.
//

import SwiftUI

struct CircularProgressView: View {
  let progress: Double
  
  var body: some View {
      ZStack {
          Circle()
              .stroke(
                  Color("SecondaryGray"),
                  lineWidth: 8
              )
          Circle()
              .trim(from: 0, to: progress)
              .stroke(
                  Color("PrimaryOrange"),
                  style: StrokeStyle(
                      lineWidth: 8,
                      lineCap: .round
                  )
              )
              .rotationEffect(.degrees(-90))
              // 1
              .animation(.easeOut, value: progress)

      }
  }
}
