//
//  ViewController.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/26/25.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1: load .obj file
        let scene = SCNScene(named: "duck.obj")
        
        // 2: add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: place camera
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
        // 4: set camera on scene
        scene?.rootNode.addChildNode(cameraNode)
        
        // 5: adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
        scene?.rootNode.addChildNode(lightNode)
        
        // 6: creating and adding ambient light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        
    }
}
