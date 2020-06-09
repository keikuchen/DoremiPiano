//
//  ContentView.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/05/27.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let movableDoLongerKeyNotes = ["ド", "レ", "ミ", "ファ", "ソ", "ラ", "シ"]
    let movableDoShorterKeyNotes = ["デ", "リ", "", "フィ", "サ", "チ"]
    
    @State var fixedDoLongerKeyNotes = ["C3", "D", "E", "F", "G", "A", "B"]
    @State var fixedDoShorterKeyNotes = ["C#/D♭", "D#/E♭", "", "F#/G♭", "G#/A♭", "A#/B♭"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 64.0 / 255, green: 64.0 / 255, blue: 64.0 / 255)
                .edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top) {
                HStack(spacing: 0.0) {
                    ForEach(0..<7) { i in
                        Key(keyColor: Color.white,
                            textColor: Color.black,
                            width: 40,
                            height: 150,
                            movableDoName: self.movableDoLongerKeyNotes[i],
                            fixedDoName: self.fixedDoLongerKeyNotes[i],
                            audioFileName: self.movableDoLongerKeyNotes[i],
                            audioFileType: "wav"
                        )
                    }
                }
                HStack(spacing: 20.0) {
                    ForEach(0..<6) { i in
                        if i == 2 {
                            Text("")
                                .frame(width: 20, height: 100)
                        } else {
                            Key(keyColor: Color.black,
                                textColor: Color.white,
                                width: 20,
                                height: 100,
                                movableDoName: self.movableDoShorterKeyNotes[i],
                                fixedDoName: self.fixedDoShorterKeyNotes[i],
                                audioFileName: self.movableDoShorterKeyNotes[i],
                                audioFileType: "wav"
                            )
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
    }
}

struct Key: View {
    var keyColor: Color?
    var textColor: Color?
    var width: CGFloat?
    var height: CGFloat?
    
    let movableDoName: String
    let fixedDoName: String
    let audioFileName: String
    let audioFileType: String
    
//    let audioFileName: String
    @State var player: AVAudioPlayer!
    
    var body: some View {
        Button(action: {
            print(">> action")
        }) {
            VStack {
                Spacer()
                Text(movableDoName)
                    .foregroundColor(textColor)
                Text(fixedDoName)
                    .foregroundColor(Color.gray)
            }
            .frame(width: width, height: height)
            .background(keyColor)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray)
            )
            .overlay(TouchesHandler(
                didBeginTouch: {
                    print(">> did begin")
                    let url = Bundle.main.path(
                        forResource: self.audioFileName,
                        ofType: self.audioFileType
                    )
                    self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                    self.player.currentTime = 0.1
                    self.player.play()
                },
                didEndTouch: {
                    print(">> did end")
                    self.player.stop()
                }
            ))
        }
    }
}
