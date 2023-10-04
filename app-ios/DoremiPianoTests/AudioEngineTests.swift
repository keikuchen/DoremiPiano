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
