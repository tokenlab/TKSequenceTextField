//
//  TKSequenceTextField.swift
//  Pods
//
//  Created by Domene on 05/04/17.
//
//

import Foundation
import UIKit
import TLCustomMask

/*
 * CustomMaskTextField can be used with a list of masks.
 * e.g:
 *  customMaskTextField.setMaskSequence(['**.**', '***-***', '$$-$$$'])
 *
 *  Use $ for digits ($$-$$$$)
 *  Use * for characters [a-zA-Z] (**-****)
 *
 *  This custom TextField will reorder its maskSequence by mask length (smaller to bigger)
 */
public class TKSequenceTextField: UITextField, UITextFieldDelegate{
    private var customMask : TLCustomMask?
    private var currentMaskIndex : Int = 0
    private var maskSequence : [String] = []
    var cleanText : String? {
        get {
            return self.customMask?.cleanText
        }
        set {
            currentMaskIndex = maskSequence.count-1
            customMask?.formattingPattern = maskSequence[currentMaskIndex]
            var newText = customMask!.formatString(string: newValue ?? "")
            if newText.characters.count < maskSequence[currentMaskIndex].characters.count {
                if currentMaskIndex > 0 {
                    currentMaskIndex -= 1
                    customMask?.formattingPattern = maskSequence[currentMaskIndex]
                    newText = customMask!.formatString(string: newValue ?? "")
                }
            }
            self.text = newText
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        super.delegate = self
        customMask = TLCustomMask(formattingPattern: self.maskSequence.first ?? "")
    }
    
    public func setMaskSequence(maskSequence: [String]){
        self.maskSequence = sortArrayByLength(array: maskSequence);
        currentMaskIndex = 0
        customMask?.formattingPattern = self.maskSequence[currentMaskIndex];
    }
    
    private func sortArrayByLength(array: [String]) -> Array<String>{
        let sorted = array.sorted(by: {x, y -> Bool in x.characters.count < y.characters.count })
        return sorted;
    }
    
    // MARK : UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldChangeCharactersInRange(range: range, replacementString: string)
    }
    
    func shouldChangeCharactersInRange(range: NSRange, replacementString string: String) -> Bool {
        //Check if backspace was pressed
        //Detect backspace
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) { //Backspace was pressed
            if(currentMaskIndex > 0){
                if((self.text!.characters.count-1) <= maskSequence[currentMaskIndex-1].characters.count){
                    currentMaskIndex -= 1
                }
            }else{
                currentMaskIndex = 0
            }
            
            
            let string = customMask!.formatStringWithRange(range: range, string: string)
            if self.maskSequence.indices.contains(currentMaskIndex){
                self.customMask!.formattingPattern = self.maskSequence[currentMaskIndex]
            }else{
                self.customMask!.formattingPattern = ""
            }
            
            
            //remove last char
            if let text = self.text{
                self.text = text.substring(to: text.index(before: text.endIndex))
            }
            self.text = customMask!.formatString(string: self.text!)
            return false
        }
        
        if maskSequence.count > 0 {
            //if text length greater than currentMask length AND currentMask is not the last
            if((self.text!.characters.count+1) > maskSequence[currentMaskIndex].characters.count){
                if(currentMaskIndex < maskSequence.count-1){
                    currentMaskIndex += 1
                    self.customMask?.formattingPattern = self.maskSequence[currentMaskIndex]
                    self.text = customMask!.formatString(string: self.text!+string)
                }
            }else{
                self.text = customMask!.formatStringWithRange(range: range, string: string)
            }
        }else{
            return true
        }
        
        return false
    }
}
