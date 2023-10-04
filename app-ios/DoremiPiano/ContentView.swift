import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var pitch: Double = 0
    @State private var isChanging = false

    var body: some View {
        var engines = [Int:AudioEngine]()
        
        if !isChanging {
            for note in userData.notes {
                let defaultPitch = Float(note.defaultRole) - note.audioPitch
                let audioEngine = AudioEngine(file: note.audio, defaultPitch: defaultPitch)
                audioEngine.start()
                engines.updateValue(audioEngine, forKey: note.defaultRole)
            }
        }
        
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Pitch\n\(Int(self.pitch))")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Slider(value: self.$pitch, in: -12...12, step: 1) { isChanging in
                        self.isChanging = isChanging
                    }

                    ZStack(alignment: .top) {
                        // Longer Keys
                        HStack(spacing: 0.0) {
                            ForEach(longerKeyNumbers, id: \.self) { noteNumber in
                                Key(keyColor: Color.white,
                                    textColor: Color.black,
                                    width: geometry.size.width / CGFloat(longerKeyNumbers.count),
                                    height: geometry.size.height / 2,
                                    fixedDoName: fixedDoNote(noteNumber: noteNumber + Int(self.pitch)),
                                    movableDoName: movableDoNote(noteNumber: noteNumber),
                                    isBlank: false
                                )
                                .overlay(CustomTapGestureHandler(
                                    touchesBegan: {
                                        print("touch began")
                                        engines[noteNumber]?.play(pitch: Int(self.pitch))
                                    },
                                    touchesEnded: {
                                        print("touch ended")
                                        engines[noteNumber]?.stop()
                                    }
                                ))
                            }
                        }
                        // Shorter Keys
                        HStack(spacing: geometry.size.width / (CGFloat(longerKeyNumbers.count) * 2)) {
                            ForEach(shorterKeyNumbers, id: \.self) { noteNumber in
                                Key(keyColor: Color.black,
                                    textColor: Color.white,
                                    width: geometry.size.width / (CGFloat(longerKeyNumbers.count) * 2),
                                    height: geometry.size.height / 3,
                                    fixedDoName: fixedDoNote(noteNumber: noteNumber + Int(self.pitch)),
                                    movableDoName: movableDoNote(noteNumber: noteNumber),
                                    isBlank: noteNumber == 0
                                )
                                .overlay(CustomTapGestureHandler(
                                    touchesBegan: {
                                        print("touch began")
                                        engines[noteNumber]?.play(pitch: Int(self.pitch))
                                    },
                                    touchesEnded: {
                                        print("touch ended")
                                        engines[noteNumber]?.stop()
                                    }
                                ))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(UserData())
    }
}
