//
//  WheelColorPickerView.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 26/02/2024.
//

import SwiftUI

struct WheelColorPickerView: View {
    
    @State private var selectedColorIndex: Int? = nil
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 1) {
                    
                    Color.white
                        .aspectRatio(2, contentMode: .fit)
                    
                    ForEach(0..<21) { index in
                      
                        ColorRow(hueValue: index)
                            .frame(height: 20)
                            .id(index)
                            .overlay {
                                if index == selectedColorIndex {
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 3)
                                }
                            }
                            .zIndex(index == selectedColorIndex ? 100 : 1)
                            .visualEffect{ content, proxy in
                            content
                                    .opacity(opacity(for: proxy))
                            }
                    }
                    
                    Color.white
                        .aspectRatio(2, contentMode: .fit)
                    
                }
                .padding()
                .scrollTargetLayout()
            }
            .scrollPosition(id: $selectedColorIndex, anchor: .center)
            .aspectRatio(1, contentMode: .fit)
            
            HStack {
                Text("You selected:")
                
                if let selectedColorIndex {
                    ColorRow(hueValue: selectedColorIndex)
                } else {
                    Color.clear
                }
            }
            .frame(height: 100)
        }
        .onAppear {
            selectedColorIndex = 10
        }
    }
    
    func opacity(for proxy: GeometryProxy) -> Double {
        
        let scrollViewHeight = proxy.bounds(of: .scrollView)?.height ?? 100
        let rowCenterPosition = proxy.frame(in: .scrollView).midY
        let distanceFromScrollCenter = abs(scrollViewHeight / 2 - rowCenterPosition)
        
        return 1 - Double(distanceFromScrollCenter / scrollViewHeight) * 2
    }
}

fileprivate struct ColorRow:View {
    
    var hueValue: Int
    let numberOfColorStops: Int = 20
    
    var body: some View {
        Color(hue: Double(hueValue) / Double(numberOfColorStops),
              saturation: 1,
              brightness: 1)
    }
}

#Preview {
    WheelColorPickerView()
}
