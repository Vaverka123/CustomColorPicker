//
//  ContentView.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 26/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedColor = Color.blue
    
    var body: some View {
       ColorPicker("Pick a color", selection: $selectedColor)
        
            .padding()
    }
}

#Preview {
    ContentView()
}
