//
//  quacks.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 3/4/25.
//
import AVFoundation

func playQuackSound(random rand: Bool) {
    var audioPlayer: AVAudioPlayer?
    // Ensure the audio session is set up for playback
    do {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playback, mode: .default, options: .mixWithOthers)
        try audioSession.setActive(true)
    } catch {
        print("Error setting up audio session: \(error.localizedDescription)")
        return
    }

    // Try loading the sound file
    guard let url = Bundle.main.url(forResource: rand ? randQuackName() : "quack", withExtension: "mp3") else {
        print("Sound file not found")
        return
    }

    // Play the sound
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    } catch {
        print("Failed to play sound: \(error.localizedDescription)")
    }
}

func randQuackName() -> String {
    let options = [
        "quack",
        "quack",
        "quack",
        "quack",
        "quack2",
        "quack3",
        "quack4",
        "quack5",
        "quack6",
        "quack7",
        "quack8"
    ]
    return options.randomElement()! // ! should not be an issue
}
