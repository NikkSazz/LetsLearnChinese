//
//  duckieView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/26/25.
//

import SwiftUI
import SceneKit

struct duckieView: View {
    var body: some View{
        ZStack{
            DefaultBackground()
            
            VStack{
                

                TopBar(title: "Therapist", subtitle: "Rubber Ducky")
                    .padding(.top, 50)
                    .padding(.bottom, -1) // so they merge well together
                
                
                

                
                
                SceneView(
                    scene: {
                        let scene = SCNScene(named: "duck.obj")
                        
                        // Background Color
                        let mycolor = UIColor(red: 0x5A / 255.0, green: 0x54 / 255.0, blue: 0x54 / 255.0, alpha: 1.0)
                        scene?.background.contents = mycolor
                        // /bg color
                        
                        // Locate the texture and apply it to the first material
                        let duckTexture = UIImage(named: "duck.png")
                       let material = SCNMaterial()
                       material.diffuse.contents = duckTexture
                       scene?.rootNode.childNodes.forEach { $0.geometry?.materials = [material] }
                        
                        // autorotate
                        let duration: TimeInterval = 60
                        let rootNode = scene?.rootNode
                        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: duration)  // Slowly rotating over 10 seconds
                        let repeatAction = SCNAction.repeatForever(rotateAction)  // Repeat indefinitely
                        rootNode?.runAction(repeatAction)
                        // / autorotate
                        
                        return scene
                    }(),
                    options: [.autoenablesDefaultLighting, .allowsCameraControl]
                )
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 15) {
                        Spacer()
                        HStack{
                            Text("What is this?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.accent)
                            
                            Spacer()
                            
                            Text("   Quack   ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue.opacity(0.5))
                                )
                            
                            Spacer()
                            
                            Text("   Duck   ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue.opacity(0.5))
                                )
                        } // h
                        .padding(.horizontal)
                        
                        Text(
                             "The humble RUBBER DUCKY, often associated with bath time and childhood, holds a unique and  vital role in programming and coding.\nThe  technique of \"rubber duck debugging\".\n\nAs you get a difficult error in your code, you take a mental break, talking to a rubber ducky, and literally explaining to it your error. As you explain your error to a physical object, you are more likely to understand and solve the problem in your head! No worries of being judged for bad code, it's a duck after all"
                        )
                            .foregroundStyle(.accent.opacity(0.8))
                        
                        Spacer()
                    } // v
                    .padding(.horizontal)
                } // scroll view
                
                Spacer(minLength: 0)
                
                BottomBar()
            } // v
            .ignoresSafeArea()
        }// z
    }// body
} // struct

#Preview {
    duckieView()
}

// Data Model...
struct Model : Identifiable {
    
    var id : Int
    var name : String
    var modelName : String
    var details : String
}
