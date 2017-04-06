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
        sequenceTextField.setMaskSequence(maskSequence: ["$$.$$","$$$-$$"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

