//
//  AudioEngineTests.swift
//  DoremiPianoTests
//
//  Created by Kei Kashi on 2020/06/24.
//

import XCTest
@testable import DoremiPiano
import AVFoundation

class AudioEngineTests: XCTestCase {
    var audioEngine: AudioEngine!
    var audioFile: AVAudioFile!
    
    override func setUpWithError() throws {
        let url = try XCTUnwrap(Bundle.main.url(forResource: "sample", withExtension: "mp3"))
        audioFile = try AVAudioFile(forReading: url)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStart() {
        audioEngine = AudioEngine(file: audioFile, defaultPitch: 0)
        audioEngine.start()
        XCTAssertTrue(audioEngine.engine.isRunning)
    }

    func testPlay() throws {
        audioEngine = AudioEngine(file: audioFile, defaultPitch: 0)
        audioEngine.play(pitch: 0)
        XCTAssertTrue(audioEngine.audioPlayer.isPlaying)
    }
    
    func testChangePitch() throws {
        audioEngine = AudioEngine(file: audioFile, defaultPitch: 2)
        audioEngine.play(pitch: 3)
        XCTAssertEqual(audioEngine.pitchUnit.pitch, 500)
    }
    
    func testStop() {
        testStart()
        audioEngine.stop()
        XCTAssertFalse(audioEngine.audioPlayer.isPlaying)
    }
}
