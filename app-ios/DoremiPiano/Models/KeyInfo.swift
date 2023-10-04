let longerKeyNumbers = [67, 69, 71, 72, 74, 76, 77, 79, 81, 83, 84, 86, 88]
let shorterKeyNumbers = [68, 70, 0, 73, 75, 0, 78, 80, 82, 0, 85, 87]

let fixedDoNotes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
let movableDoNotes = ["ド", "デ", "レ", "リ", "ミ", "ファ", "ﾌｨ", "ソ", "サ", "ラ", "チ", "シ"]

func fixedDoNote(noteNumber: Int) -> String {
    fixedDoNotes[indexOfScale(noteNumber: noteNumber)]
}

func movableDoNote(noteNumber: Int) -> String {
    movableDoNotes[indexOfScale(noteNumber: noteNumber)]
}

func indexOfScale(noteNumber: Int) -> Int {
    if noteNumber < 0 {
        return 0
    }
    let numberOfNotes: Float = 12
    return Int(Float(noteNumber).truncatingRemainder(dividingBy: numberOfNotes))
}
