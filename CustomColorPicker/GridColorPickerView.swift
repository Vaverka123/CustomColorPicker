//
//  GridColorPickerView.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 26/02/2024.
//

import SwiftUI

struct CustomColor: Identifiable, Hashable {
    let hue: CGFloat
    let saturation: CGFloat
    let brightness: CGFloat
    let id = UUID()
    
    static func spectrum() -> [CustomColor] {
        let brightnessDistance = 0.1
        let hueDistance = 0.05
        let brightnessValues = Array(stride(from: 0.0, 
                                            through: 1.0,
                                            by: brightnessDistance))
        let hueValues = Array(stride(from: 0.0, 
                                     through: 1.0,
                                     by: hueDistance))
        
        var results = [CustomColor]()
        
        for hueValue in hueValues {
            
            let row = brightnessValues.map { 
                CustomColor(hue: hueValue,
                            saturation: 1,
                            brightness: $0) }
            results.append(contentsOf: row)
            
            let rowEnd = brightnessValues.map { CustomColor(hue: hueValue,
                            saturation: $0,
                            brightness: 1)}
                .reversed()
                .dropFirst()
            
            results.append(contentsOf: rowEnd)
        }
        
       return results
    }
}


struct GridColorPickerView: View {
    
    @State private var selectedColor: CustomColor? = nil
    let colorOptions = CustomColor.spectrum()
    let colorSize: CGFloat = 30
    
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
                //      .scrollClipDisabled(true)
                
                //    Spacer()
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
                
                Spacer()
                
            }
            .onAppear {
                selectedColor = colorOptions[colorOptions.count / 2]
            }
        }
    }
    
    func scaleAmount(for proxy: GeometryProxy) -> Double {
        
        let scrollViewHeight = proxy.bounds(of: .scrollView)?.height ?? 100
        let rowCenterPositionY = proxy.frame(in: .scrollView).midY
        let distanceFromScrollCenterY = abs(scrollViewHeight / 2 - rowCenterPositionY)
        
        let scrollViewWidth = proxy.bounds(of: .scrollView)?.width ?? 100
        let rowCenterPositionX = proxy.frame(in: .scrollView).midX
        let distanceFromScrollCenterX = abs(scrollViewWidth / 2 - rowCenterPositionX)
        
        return 1.1 - (Double(distanceFromScrollCenterX / scrollViewWidth) + Double(distanceFromScrollCenterY / scrollViewHeight)) * 0.75
    }


#Preview {
    GridColorPickerView()
}
