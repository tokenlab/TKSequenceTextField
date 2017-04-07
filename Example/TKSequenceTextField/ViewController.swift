//
//  ViewController.swift
//  TKSequenceTextField
//
//  Created by Edudjr on 04/05/2017.
//  Copyright (c) 2017 Edudjr. All rights reserved.
//

import UIKit
import TKSequenceTextField

class ViewController: UIViewController {

    @IBOutlet weak var sequenceTextField: TKSequenceTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sequenceTextField.setMaskSequence(maskSequence: ["$$.$","$$$.$$"])
//        inputToTextField(string: "12345")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func inputToTextField(string: String){
        for index in string.characters.indices {
            self.sequenceTextField.textField(sequenceTextField,
                                             shouldChangeCharactersIn: NSMakeRange((sequenceTextField.text?.characters.count)!, 0),
                                             replacementString: String(string[index]))
        }
    }

}

