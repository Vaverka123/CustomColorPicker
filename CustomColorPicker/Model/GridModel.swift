//
//  GridModel.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 29/02/2024.
//

import Foundation

let colorOptions = CustomColor.spectrum()
let colorSize: CGFloat = 30

struct CustomColor: Identifiable, Hashable {
    let hue: CGFloat
    let saturation: CGFloat
    let brightness: CGFloat
    let id = UUID()
}
