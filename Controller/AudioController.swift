//
//  AudioController.swift
//  War
//
//  Created by Kenny on 8/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import AVFoundation

class AudioPlayer {
    // MARK: - Types -
    enum FileType: String {
        case wav
    }

    enum Sound: String {
        case fight
        case battleSpeech
    }

    // MARK: - Properties -
    let sounds: [Sound: FileType] = [
        .fight: .wav,
        .battleSpeech: .wav
    ]

    // MARK: - Players -
    var speechPlayer: AVAudioPlayer?
    var fightPlayer: AVAudioPlayer?

    func playSound(sound: Sound) {

        guard let fileExtension = sounds[sound],
            let filePath = Bundle.main.path(forResource: sound.rawValue, ofType: fileExtension.rawValue) else {

                print("invalid file path or type for \(sound.rawValue).\(String(describing: sounds[sound]?.rawValue))")
                return
        }

        do {
            // setup audio session
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            // setup player
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath), fileTypeHint: fileExtension.rawValue)
            player.prepareToPlay()

            // assign player
            // TODO: Research playing multiple sounds at once - might be a cleaner way
            if sound == .battleSpeech {
                speechPlayer = player
                speechPlayer?.play()
            } else if sound == .fight {
                fightPlayer = player
                fightPlayer?.play()
            }

        } catch {
            print("Error playing audio file \(sound.rawValue).\(String(describing: sounds[sound])): \(error)")
        }
    }
}
