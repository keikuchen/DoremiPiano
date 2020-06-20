//
//  ContentView.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/05/27.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var pitch = 0

    var body: some View {
        var engines = [Int:AudioEngine]()
        for note in userData.notes {
            let defaultPitch = note.defaultRole - note.audioPitch
            engines.updateValue(
                AudioEngine(audioFileName: note.audioName, audioFileType: "wav", defaultPitch: defaultPitch),
                forKey: note.defaultRole
            )
        }
        
        return ZStack(alignment: .bottom) {
            Color(red: 64.0 / 255, green: 64.0 / 255, blue: 64.0 / 255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Stepper(value: $pitch, in: -12...12) {
                    Text("Pitch: \(pitch)")
                }

                ZStack(alignment: .top) {
                    HStack(spacing: 0.0) {
                        ForEach(longerKeyNumbers, id: \.self) { noteNumber in
                            Key(keyColor: Color.white,
                                textColor: Color.black,
                                width: 46,
                                height: 150,
                                movableDoName: movableDoNotes[noteNumber] ?? "",
                                fixedDoName: fixedDoNotes[self.mod12(noteNumber: noteNumber)]
                            )
                            .overlay(TouchesHandler(
                                didBeginTouch: {
                                    print(">> did begin")
                                    engines[noteNumber]?.play(pitch: self.pitch)
                                },
                                didEndTouch: {
                                    print(">> did end")
                                    engines[noteNumber]?.stop()
                                }
                            ))
                        }
                    }
                    HStack(spacing: 23.0) {
                        ForEach(shorterKeyNumbers, id: \.self) { noteNumber in
                            Key(keyColor: Color.black,
                                textColor: Color.white,
                                width: 23,
                                height: 100,
                                movableDoName: movableDoNotes[noteNumber] ?? "",
                                fixedDoName: fixedDoNotes[self.mod12(noteNumber: noteNumber)]
                            )
                            .overlay(TouchesHandler(
                                didBeginTouch: {
                                    print(">> did begin")
                                    engines[noteNumber]?.play(pitch: self.pitch)
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
    
    func mod12(noteNumber: Int) -> Int {
        var result = Int(Float(noteNumber + self.pitch).truncatingRemainder(dividingBy: 12))
        if result < 0 {
            result = 0
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
            .environmentObject(UserData())
    }
}
