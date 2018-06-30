//
//  ViewController.swift
//  First to 30
//
//  Created by Daniel on 30/6/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class ClickerViewController: UIViewController {

    @IBOutlet var counterLabel: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = counter
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func screenTapped(_ sender: Any) {
    }
    
}

