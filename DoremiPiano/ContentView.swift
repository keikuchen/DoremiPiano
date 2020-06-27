//
//  ContentView.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/05/27.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var pitch: Double = 0
    @State private var isChanging = false

    var body: some View {
        var engines = [Int:AudioEngine]()
        if !isChanging {
            print("body start")
            for note in userData.notes {
                let defaultPitch = Float(note.defaultRole) - note.audioPitch
                let audioEngine = AudioEngine(file: note.audio, defaultPitch: defaultPitch)
                audioEngine.start()
                engines.updateValue(audioEngine, forKey: note.defaultRole)
            }
        }
        
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color(red: 64.0 / 255, green: 64.0 / 255, blue: 64.0 / 255)
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
                                    fixedDoName: fixedDoNotes[self.indexOfScale(noteNumber: noteNumber)],
                                    movableDoName: movableDoNotes[noteNumber] ?? ""
                                )
                                .overlay(TouchesHandler(
                                    didBeginTouch: {
                                        print(">> did begin")
                                        engines[noteNumber]?.play(pitch: Int(self.pitch))
                                    },
                                    didEndTouch: {
                                        print(">> did end")
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
                                    fixedDoName: fixedDoNotes[self.indexOfScale(noteNumber: noteNumber)],
                                    movableDoName: movableDoNotes[noteNumber] ?? ""
                                )
                                .overlay(TouchesHandler(
                                    didBeginTouch: {
                                        print(">> did begin")
                                        engines[noteNumber]?.play(pitch: Int(self.pitch))
                                    },
                                    didEndTouch: {
                                        print(">> did end")
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
    
    private func indexOfScale(noteNumber: Int) -> Int {
        let shiftedNumber = Float(noteNumber + Int(self.pitch))
        if shiftedNumber < 0 {
            return 0
        }
        let numberOfNotes: Float = 12
        return Int(shiftedNumber.truncatingRemainder(dividingBy: numberOfNotes))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(UserData())
    }
}
