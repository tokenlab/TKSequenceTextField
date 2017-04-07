import UIKit
import XCTest
import TKSequenceTextField

class Tests: XCTestCase, UITextFieldDelegate {
    
    var sequenceTextField = TKSequenceTextField()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyMaskSequence() {
        
        inputToTextField(textField: sequenceTextField, string: "123456")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "123456")
        
        sequenceTextField.setMaskSequence(maskSequence: [""])
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123456123456")
    }
    
    func testSetTextToEmpty(){
        inputToTextField(textField: sequenceTextField, string: "123456")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "123456")
        
        sequenceTextField.text = ""
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123456")
        
        sequenceTextField.text = ""
        sequenceTextField.setMaskSequence(maskSequence: ["$$$.$$$"])
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123.456")
    }
    
    func testSetTextToString(){
        inputToTextField(textField: sequenceTextField, string: "123456")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "123456")
        
        sequenceTextField.text = "123"
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123123456")
        
        sequenceTextField.text = "123"
        sequenceTextField.setMaskSequence(maskSequence: ["$$$.$$$"])
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123.123")
        
        sequenceTextField.text = "123"
        sequenceTextField.setMaskSequence(maskSequence: [""])
        inputToTextField(textField: sequenceTextField, string: "123456")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "123123456")
    }
    
    func testOneDigitMaskWithoutSpecialChars() {
        sequenceTextField.setMaskSequence(maskSequence: ["$$$"])
        inputToTextField(textField: sequenceTextField, string: "123456")
        let text = sequenceTextField.text!
        XCTAssertEqual(text, "123")
    }
    
    func testOneDigitMaskWithSpecialChars() {
        sequenceTextField.text = ""
        sequenceTextField.setMaskSequence(maskSequence: ["$$$.$$$"])
        inputToTextField(textField: sequenceTextField, string: "123456")
        let text = sequenceTextField.text!
        XCTAssertEqual(text, "123.456")
    }
    
    func testOneCharMaskWithoutSpecialChars() {
        sequenceTextField.setMaskSequence(maskSequence: ["***"])
        inputToTextField(textField: sequenceTextField, string: "abcdef")
        let text = sequenceTextField.text!
        XCTAssertEqual(text, "abc")
    }
    
    func testOneCharMaskWithSpecialChars(){
        sequenceTextField.setMaskSequence(maskSequence: ["***.***"])
        inputToTextField(textField: sequenceTextField, string: "abcdef")
        let text = sequenceTextField.text!
        XCTAssertEqual(text, "abc.def")
    }
    
    func testTwoDigitsMasks() {
        sequenceTextField.setMaskSequence(maskSequence: ["$$$","$$$$"])
        inputToTextField(textField: sequenceTextField, string: "123")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "123")
        
        sequenceTextField.text = ""
        inputToTextField(textField: sequenceTextField, string: "1234")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "1234")
        
        sequenceTextField.text = ""
        sequenceTextField.setMaskSequence(maskSequence: ["$$.$","$.$$$"])
        inputToTextField(textField: sequenceTextField, string: "123")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12.3")
        
        sequenceTextField.text = ""
        inputToTextField(textField: sequenceTextField, string: "1234")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "1.234")
    }
    
    func testBackspaceWithOneMask(){
        sequenceTextField.setMaskSequence(maskSequence: ["$$$"])
        inputToTextField(textField: sequenceTextField, string: "123")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "123")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "1")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "")
    }
    
    func testBackspaceWithTwoMasks(){
        sequenceTextField.setMaskSequence(maskSequence: ["$$.$","$$.$$$"])
        
        //First Mask
        inputToTextField(textField: sequenceTextField, string: "123")
        var text = sequenceTextField.text!
        XCTAssertEqual(text, "12.3")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "1")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "")
        
        //Second Mask
        inputToTextField(textField: sequenceTextField, string: "12345")
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12.345")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12.34")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12.3")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "12")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "1")
        
        inputBackspaceToTextField(textField: sequenceTextField, ntimes: 1)
        text = sequenceTextField.text!
        XCTAssertEqual(text, "")
    }
}

func inputToTextField(textField: TKSequenceTextField, string: String){
    for index in string.characters.indices {
        textField.textField(textField,
                            shouldChangeCharactersIn: NSMakeRange((textField.text?.characters.count)!, 0),
                            replacementString: String(string[index]))
    }
}

func inputBackspaceToTextField(textField: TKSequenceTextField, ntimes: Int){
    for _ in 0..<ntimes {
        textField.textField(textField,
                            shouldChangeCharactersIn: NSMakeRange((textField.text?.characters.count)!, 1),
                            replacementString: "\\b")
    }
}
