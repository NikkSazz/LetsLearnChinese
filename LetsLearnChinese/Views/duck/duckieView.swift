//
//  duckieView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/26/25.
//

import SwiftUI
import SceneKit


struct duckieView: View {
    init(){ // for picker style
        UISegmentedControl.appearance().selectedSegmentTintColor = .accent
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)    }
    
    @State var duckType: Int = 0
    
    let ducks = [
        Model(id: 0, name: "Rubber", modelName: "duck.obj", textureName: "duck.png"),
        Model(id: 1, name: "Green", modelName: "greenduck.obj", textureName: "greenduck.png"),
        Model(id: 2, name: "Traveler ", modelName: "duck_fin_posed.obj", textureName: "greenduck.png"),
        Model(id: 3, name: "Wooden", modelName: "wooden_duck_toy.obj", textureName: "greenduck.png")
        ]
    var body: some View{
        ZStack{
            DefaultBackground()
            
            VStack{
                

                TopBar(title: "Therapist", subtitle: "Rubber Ducky")
                    .padding(.top, 50)
                    .padding(.bottom, -1) // so they merge well together
                
                
                SceneView(
                    scene: {
                        let selectedDuck = ducks[duckType]
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
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.25) // change for scale
                
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 15) {
                        Spacer()
                        HStack{
                            Text("What is this?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.accent)
                            
                            Spacer()
                            
                            Button {
                                print("Quack!")
                            } label: {
                                Text("Quack       ")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.accent)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.black.opacity(0.5))
                                    )
                            }
                        } // h
                        .padding(.horizontal)
                        
                        Picker("Select Duck ¬¬", selection: $duckType) {
                            ForEach(ducks) { duck in
                                Text(duck.name).tag(duck.id)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .tint(.blue) // Use your preferred color here
                        .padding(.horizontal)

                       
                        
                        Text("The humble RUBBER DUCKY, often associated with bath time and childhood, holds a unique and  vital role in programming and coding.\nThe  technique of \"rubber duck debugging\".")
                            .foregroundStyle(.accent.opacity(0.8))
                            .padding(.horizontal)
                        
                        Text("As you get a difficult error in your code, you take a mental break, talking to a rubber ducky, and literally explaining to it your error. As you explain your error to a physical object, you are more likely to understand and solve the problem in your head! No worries of being judged for bad code, it's a duck after all")
                            .foregroundStyle(.accent.opacity(0.8))
                            .padding(.horizontal)
                        
                        Text("How can you use this for Chinese?")
                            .font(.title2)
                            .foregroundStyle(.accent)
                        
                        Text("Explaining what you've learned out loud to the duck. A new character, what's special about it, what should you keep in mind while using that character.")
                            .foregroundStyle(.accent.opacity(0.8))
                            .padding(.horizontal)
                        
                        Text("This helps reinforce your memory and understanding.")
                            .foregroundStyle(.accent.opacity(0.8))
                            .padding(.horizontal)
                        
                        Text("*Note some of the ducks may not be centerd.")
                            .foregroundStyle(.gray.opacity(0.5))

                        
                        Spacer(minLength: 30)
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
    var textureName : String
}
