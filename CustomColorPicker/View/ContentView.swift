//
//  ContentView.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 26/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            
            DefaultColorPickerView()
                .tabItem {
                    Label("Default", systemImage: "paintpalette")
                }
            
            WheelColorPickerView()
                .tabItem {
                    Label("Wheel", systemImage: "filemenu.and.selection")
                }
            
            GridColorPickerView()
                .tabItem {
                    Label("Grid", systemImage: "square.grid.3x3.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
