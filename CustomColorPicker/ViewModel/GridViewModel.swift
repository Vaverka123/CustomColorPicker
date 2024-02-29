//
//  GridViewModel.swift
//  CustomColorPicker
//
//  Created by Vera Maslava on 29/02/2024.
//

import SwiftUI

extension CustomColor {
    
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

func scaleAmount(for proxy: GeometryProxy) -> Double {
    
    let scrollViewHeight = proxy.bounds(of: .scrollView)?.height ?? 100
    let rowCenterPositionY = proxy.frame(in: .scrollView).midY
    let distanceFromScrollCenterY = abs(scrollViewHeight / 2 - rowCenterPositionY)
    
    let scrollViewWidth = proxy.bounds(of: .scrollView)?.width ?? 100
    let rowCenterPositionX = proxy.frame(in: .scrollView).midX
    let distanceFromScrollCenterX = abs(scrollViewWidth / 2 - rowCenterPositionX)
    
    return 1.1 - (Double(distanceFromScrollCenterX / scrollViewWidth) + Double(distanceFromScrollCenterY / scrollViewHeight)) * 0.75
}
