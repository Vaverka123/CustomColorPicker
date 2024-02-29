//
//  WheelModel.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 29/02/2024.
//

import SwiftUI

struct ColorRow:View {
    
    var hueValue: Int
    let numberOfColorStops: Int = 20
    
    var body: some View {
        Color(hue: Double(hueValue) / Double(numberOfColorStops),
              saturation: 1,
              brightness: 1)
    }
}
