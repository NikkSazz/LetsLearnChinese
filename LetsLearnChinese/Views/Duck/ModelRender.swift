//
//  ModelRender.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 3/5/25.
//

import Foundation
import SceneKit
import SwiftUICore
import _SceneKit_SwiftUI

struct ModelRender: View {
    let selectedDuck: Duck
    
    var body: some View {
        
        SceneView(
            scene: {
                let scene = SCNScene(named: selectedDuck.modelName)
                
                // Background Color
                let mycolor = UIColor(red: 0x5A / 255.0, green: 0x54 / 255.0, blue: 0x54 / 255.0, alpha: 1.0)
                scene?.background.contents = mycolor
                // /bg color
                

                let duckTexture = UIImage(named: selectedDuck.textureName)
                let material = SCNMaterial()
                material.diffuse.contents = duckTexture
                scene?.rootNode.childNodes.forEach { $0.geometry?.materials = [material] }
                    
                // autorotate
                let duration: TimeInterval = 30
                let rootNode = scene?.rootNode
                let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: duration)  // Slowly rotating over 10 seconds
                let repeatAction = SCNAction.repeatForever(rotateAction)  // Repeat indefinitely
                rootNode?.runAction(repeatAction)
                // / autorotate
                
                return scene
            }(),
            options: [.autoenablesDefaultLighting, .allowsCameraControl]
        )
        
    }
}
