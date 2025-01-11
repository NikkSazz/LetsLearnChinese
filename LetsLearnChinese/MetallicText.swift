//
//  MetallicText.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/11/25.
//

import SwiftUI
import UIKit

struct MetallicText: UIViewRepresentable {
    var text: String
    var fontName: String
    var fontSize: CGFloat
    var gradientColors: [UIColor]
    
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear // Ensure the background is transparent
        
        // Create a label
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0 // Allow multi-line text if needed
        
        // Set the custom font
        if let customFont = UIFont(name: fontName, size: fontSize) {
            label.font = customFont
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize) // Fallback font
            print("Custom font not found: \(fontName)")
        }
        
        // Ensure the label resizes dynamically
        label.sizeToFit()
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = label.bounds // Initially match the label's bounds
        
        // Create a mask layer using the label
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return container }
        label.layer.render(in: context)
        let maskImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let maskLayer = CALayer()
        maskLayer.contents = maskImage?.cgImage
        maskLayer.frame = label.bounds
        
        // Apply the mask to the gradient
        gradientLayer.mask = maskLayer
        container.layer.addSublayer(gradientLayer)
        
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update view if needed
        if let gradientLayer = uiView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = uiView.bounds
        }
    }
}
