import AVFoundation

let noteData: [Note] = load("noteData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class AudioStore {
    typealias _AudioDictionary = [String: AVAudioFile]
    fileprivate var audios: _AudioDictionary = [:]

    static var shared = AudioStore()
    
    func audio(name: String, type: String) -> AVAudioFile {
        let index = _guaranteeAudio(name: name, type: type)
        
        return audios.values[index]
    }

    static func loadAudio(name: String, type: String) -> AVAudioFile {
        guard let url = Bundle.main.url(forResource: name, withExtension: type)
            else {
                fatalError("Couldn't find audio \(name).\(type) from main bundle.")
        }
        
        do {
            return try AVAudioFile(forReading: url)
        } catch {
            fatalError("Couldn't load audio \(name).\(type) from main bundle.")
        }
    }
    
    fileprivate func _guaranteeAudio(name: String, type: String) -> _AudioDictionary.Index {
        if let index = audios.index(forKey: name) { return index }
        
        audios[name] = AudioStore.loadAudio(name: name, type: type)
        return audios.index(forKey: name)!
    }
}
