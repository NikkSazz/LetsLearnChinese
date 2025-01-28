//
//  duckieView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/26/25.
//

import SwiftUI
import SceneKit

struct duckieView: View {
    
    @State var models = [
        
        Model(id: 0, name: "Earth", modelName: "Earth.usdz", details: "Earth is the third planet from the Sun and the only astronomical object known to harbor life. According to radiometric dating estimation and other evidence, Earth formed over 4.5 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, which is Earth's only natural satellite. Earth orbits around the Sun in 365.256 solar days.")
    ]


    @State var index = 0


    var body: some View{
        ZStack{
            DefaultBackground()
            
            VStack{
                

                TopBar(title: "DUCK", subtitle: "DuckieDuckie")
                    .padding(.top, 50)
                    .padding(.bottom, -1) // so they merge well together
                
                
                SceneView(
                    scene: {
                        let scene = SCNScene(named: "duck.obj")
                        
                        // Background Color
                        let mycolor = UIColor(red: 0x5A / 255.0, green: 0x54 / 255.0, blue: 0x54 / 255.0, alpha: 1.0)
                        scene?.background.contents = mycolor
                        // /bg color
                        
                        // autorotate
                        let rootNode = scene?.rootNode
                        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 10)  // Slowly rotating over 10 seconds
                        let repeatAction = SCNAction.repeatForever(rotateAction)  // Repeat indefinitely
                        rootNode?.runAction(repeatAction)
                        // / autorotate
                        
                        return scene
                    }(),
                    options: [.autoenablesDefaultLighting, .allowsCameraControl]
                )
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 15, content: {
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
                        
                        Text(models[0].details)
                            .foregroundStyle(.accent.opacity(0.8))
                    })
                    .padding(.horizontal)
                }
                
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
