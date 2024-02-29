//
//  DefaultColorPicker.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 29/02/2024.
//

import SwiftUI

struct DefaultColorPickerView: View {
    
    @State private var selectedColor = Color.blue
    
    var body: some View {
        ColorPicker("Pick a color", selection: $selectedColor)
             .padding()
    }
}

#Preview {
    DefaultColorPickerView()
}
