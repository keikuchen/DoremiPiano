import SwiftUI

struct Key: View {
    let keyColor: Color
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    let fixedDoName: String
    let movableDoName: String
    let isBlank: Bool
    
    var body: some View {
        Group {
            if isBlank {
                Text("")
                    .frame(width: width, height: height)
            } else {
                VStack {
                    Spacer()
                    Text(fixedDoName)
                        .foregroundColor(Color.gray)
                    Text(movableDoName)
                        .foregroundColor(textColor)
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
                    fixedDoName: "F",
                    movableDoName: "ファ",
                    isBlank: false
                )
                Key(keyColor: Color.black,
                    textColor: Color.white,
                    width: 20,
                    height: 100,
                    fixedDoName: "F#",
                    movableDoName: "ﾌｨ",
                    isBlank: false
                )
            }
            ZStack(alignment: .top) {
                Key(keyColor: Color.white,
                    textColor: Color.black,
                    width: 40,
                    height: 150,
                    fixedDoName: "F#",
                    movableDoName: "ファ",
                    isBlank: false
                )
                Key(keyColor: Color.black,
                    textColor: Color.white,
                    width: 20,
                    height: 100,
                    fixedDoName: "",
                    movableDoName: "",
                    isBlank: true
                )
            }
        }
    }
}
