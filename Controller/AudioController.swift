//
//  AudioController.swift
//  War
//
//  Created by Kenny on 8/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import AVFoundation

class AudioPlayer {

    var player: AVAudioPlayer?

    enum FileType: String {
        case wav
    }

    enum Sound: String {
        case fight
        case battleSpeech
    }

    let sounds: [Sound: FileType] = [
        .fight: .wav,
        .battleSpeech: .wav
    ]

    func playSound(sound: Sound) {
        guard let fileExtension = sounds[sound],
            let filePath = Bundle.main.path(forResource: sound.rawValue, ofType: fileExtension.rawValue) else {
                print("invalid file path or type for \(sound.rawValue).\(String(describing: sounds[sound]?.rawValue))")
                return
        }

        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
        } catch {
            print("Error playing audio file \(sound.rawValue).\(String(describing: sounds[sound])): \(error)")
        }
        player?.play()
    }
}
