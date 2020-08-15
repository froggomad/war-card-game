//
//  AudioController.swift
//  War
//
//  Created by Kenny on 8/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import AVFoundation

class AudioPlayer {

    var speechPlayer: AVAudioPlayer?
    var fightPlayer: AVAudioPlayer?

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
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            if sound == .battleSpeech {
                speechPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath), fileTypeHint: fileExtension.rawValue)

                speechPlayer?.prepareToPlay()
                speechPlayer?.play()
            } else if sound == .fight {
                fightPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath), fileTypeHint: fileExtension.rawValue)
                fightPlayer?.prepareToPlay()
                fightPlayer?.play()
            }


        } catch {
            print("Error playing audio file \(sound.rawValue).\(String(describing: sounds[sound])): \(error)")
        }
    }
}
