import XCTest

class DoremiPianoUITests: XCTestCase {
    
    let app = XCUIApplication()
    var keyParent: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
        keyParent = try XCTUnwrap(app
            .children(matching: .window).element(boundBy: 0)
            .children(matching: .other).element
            .children(matching: .other).element
            .children(matching: .other).element)
    }

    override func tearDownWithError() throws {
    }
    
    func testAudio() throws {
        var keys: [XCUIElement] = []
        for i in 0...24 {
            keys.append(keyParent.children(matching: .other).element(boundBy: i))
            keys[i].press(forDuration: 0.3)
        }
    }
    
    func testSliderChange() throws {
        let fiKey = keyParent.children(matching: .other).element(boundBy: 19)
        let laKey = keyParent.children(matching: .other).element(boundBy: 8)
        
        
        fiKey.press(forDuration: 0.3)
        laKey.press(forDuration: 0.3)
        app.sliders["50%"].adjust(toNormalizedSliderPosition: 0.54)
        fiKey.press(forDuration: 0.3)
        laKey.press(forDuration: 0.3)
        app.sliders["54%"].adjust(toNormalizedSliderPosition: 1.0)
        fiKey.press(forDuration: 0.3)
        laKey.press(forDuration: 0.3)
        app.sliders["100%"].adjust(toNormalizedSliderPosition: 0)
        fiKey.press(forDuration: 0.3)
        laKey.press(forDuration: 0.3)
        app.sliders["0%"].adjust(toNormalizedSliderPosition: 0.5)
        fiKey.press(forDuration: 0.3)
        laKey.press(forDuration: 0.3)
    }
}
