//
//  Key.swift
//  DoremiPiano
//
//  Created by Kei Kashi on 2020/06/09.
//

import SwiftUI

struct Key: View {
    let keyColor: Color
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    let movableDoName: String
    let fixedDoName: String
    
    var body: some View {
        Group {
            if movableDoName == "" {
                Text("")
                    .frame(width: width, height: height)
            } else {
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
            }
        }
    }
}

struct Key_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                Key(keyColor: Color.white,
                    textColor: Color.black,
                    width: 40,
                    height: 150,
                    movableDoName: "ファ",
                    fixedDoName: "F#/G♭"
                )
                Key(keyColor: Color.black,
                    textColor: Color.white,
                    width: 20,
                    height: 100,
                    movableDoName: "フィ",
                    fixedDoName: ""
                )
            }
            ZStack(alignment: .top) {
                Key(keyColor: Color.white,
                    textColor: Color.black,
                    width: 40,
                    height: 150,
                    movableDoName: "ファ",
                    fixedDoName: "F#/G♭"
                )
                Key(keyColor: Color.black,
                    textColor: Color.white,
                    width: 20,
                    height: 100,
                    movableDoName: "",
                    fixedDoName: ""
                )
            }
        }
    }
}
