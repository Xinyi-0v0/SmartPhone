//
//  ViewController.swift
//  Assignment1-HelloWorld
//
//  Created by Xinyi Zhang on 1/20/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressMe(_ sender: UIButton) {
        print("Button was pressed!")
        buttonLabel.text="Hello World"
    }
    
}

