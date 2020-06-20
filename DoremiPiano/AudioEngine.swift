//
//  AudioEngine.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/06/12.
//

import AVFoundation

class AudioEngine {
    let audioFileName: String
    let audioFileType: String
    let defaultPitch: Int

    private let engine = AVAudioEngine()
    
    // 音源（外部ファイル：AVAudioPlayerNode, システム搭載音(MIDI)：AVAudioUnitSampler）
    private let audioPlayer = AVAudioPlayerNode()
//    private(set) var sampler = AVAudioUnitSampler()
    
    // 種々のコントローラー
    private let pitchUnit = AVAudioUnitTimePitch()
    private let speedUnit = AVAudioUnitVarispeed()
    //    private let reverb = AVAudioUnitReverb()
    //    private let delay = AVAudioUnitDelay()
    
    init(audioFileName: String, audioFileType: String, defaultPitch: Int) {
        self.audioFileName = audioFileName
        self.audioFileType = audioFileType
        self.defaultPitch = defaultPitch
    }
    
    func play(pitch: Int) {
        pitchUnit.pitch = Float((defaultPitch + pitch) * 100)
        pitchUnit.rate = 2.0
//        speedUnit.rate = 2.0
        
        start()
//        if !engine.isRunning {
//            start()
//        }
        
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        let url = Bundle.main.path(
                forResource: audioFileName,
                ofType: audioFileType
        )
        let file = try! AVAudioFile(forReading: URL(fileURLWithPath: url!))
        audioPlayer.scheduleFile(file, at: AVAudioTime(hostTime: UInt64(0.1)))
        audioPlayer.play()
    }

    func start() {
        engine.attach(audioPlayer)
        engine.attach(pitchUnit)
        engine.attach(speedUnit)

        engine.connect(audioPlayer, to: pitchUnit, format: nil)
        engine.connect(pitchUnit, to: speedUnit, format: nil)
        engine.connect(speedUnit, to: engine.mainMixerNode, format: nil)

        if engine.isRunning {
            print("Audio engine already running")
            return
        }
        do {
            try engine.start()
            print("Audio engine started")
        } catch {
            print("Error: couldn't start audio engine")
            return
        }

//        let audioSession = AVAudioSession.sharedInstance()
//
//        if #available(iOS 10.0, *) {
//            try! AVAudioSession.sharedInstance().setCategory(.playback, mode:  AVAudioSession.Mode.measurement)
//        } else {
//            // Workaround until https://forums.swift.org/t/using-methods-marked-unavailable-in-swift-4-2/14949 is fixed
//            AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.CategoryOptions.mixWithOthers)
//        }
//
//        do {
//            try audioSession.setActive(true)
//        } catch {
//            print("Error: AudioSession couldn't set category active")
//            return
//        }
    }
    
    func stop() {
        audioPlayer.stop()
    }
}
