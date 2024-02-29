//
//  GridColorPickerView.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 26/02/2024.
//

import SwiftUI


struct GridColorPickerView: View {
    
    @State private var selectedColor: CustomColor? = nil
    
    var body: some View {
        VStack {
            ScrollView([.horizontal, .vertical]) {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(colorSize), spacing: 0), count: 21), spacing: 0) {
                    
                    ForEach(colorOptions) { color in
                        
                        ZStack {
                            if color == selectedColor {
                           
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .padding(-5)
                                }
                            
                            Color(hue: color.hue,
                                  saturation: color.saturation,
                                  brightness: color.brightness)
                            .cornerRadius(2)
                        }
                            
                            .shadow(radius: 1)
                            .frame(height: colorSize)
                            .id(color)
                            .zIndex(color == selectedColor ? 1 : 0)
                            .visualEffect{ content, proxy in
                                content
                                    .scaleEffect(scaleAmount(for: proxy))
                            }
                        }
                    }
                    .padding(170)
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $selectedColor, anchor: .center)
                .aspectRatio(1, contentMode: .fit)
            

                HStack(spacing: 20){
                    Text("You selected")
                        .font(.title)
                        .fixedSize()
                      
                    
                    if let selectedColor {
                        Color(hue: selectedColor.hue,
                              saturation: selectedColor.saturation,
                              brightness: selectedColor.brightness)
                        .frame(height: 20)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 50)
                
            }
            .onAppear {
                selectedColor = colorOptions[colorOptions.count / 2]
            }
        }
    }
    

#Preview {
    GridColorPickerView()
}
