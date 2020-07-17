import AVFoundation

struct Note: Hashable, Codable, Identifiable {
    var id: Int
    fileprivate var audioName: String
    fileprivate var type: String
    var audioPitch: Float
    var defaultRole: Int
}

extension Note {
    var audio: AVAudioFile {
        AudioStore.shared.audio(name: audioName, type: type)
    }
}
