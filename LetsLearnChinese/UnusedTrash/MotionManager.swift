//
//  MotionManager.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/10/25.
//
import CoreMotion

public class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var y = 0.0
    @Published var x = 0.0
    
    
    
    init() {
        motionManager.deviceMotionUpdateInterval = 1 / 8
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
}
