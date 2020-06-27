//
//  AudioEngine.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/06/12.
//

import AVFoundation

class AudioEngine {
    let file: AVAudioFile
    let defaultPitch: Float

    let engine = AVAudioEngine()
    let audioPlayer = AVAudioPlayerNode()
    let pitchUnit = AVAudioUnitTimePitch()
    
    init(file: AVAudioFile, defaultPitch: Float) {
        self.file = file
        self.defaultPitch = defaultPitch
    }

    func start() {
        engine.attach(audioPlayer)
        engine.attach(pitchUnit)
        
        engine.connect(audioPlayer, to: pitchUnit, format: nil)
        engine.connect(pitchUnit, to: engine.mainMixerNode, format: nil)

        if engine.isRunning {
            print("Audio engine already running.")
            return
        }
        do {
            try engine.start()
            print("Audio engine started.")
        } catch {
            print("Couldn't start audio engine.")
            return
        }
    }
    
    func play(pitch: Int) {
        pitchUnit.pitch = (defaultPitch + Float(pitch)) * 100
        pitchUnit.rate = 2.0
        
        if !engine.isRunning {
            start()
        }
        
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        audioPlayer.scheduleFile(file, at: nil)
        audioPlayer.play()
    }
    
    func stop() {
        audioPlayer.stop()
    }
}
