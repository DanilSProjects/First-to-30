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
    var timer: Timer!
    var time = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func update() {
        time += 0.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func screenTapped(_ sender: Any) {
        if counter < 30 {
        counter += 1
        counterLabel.text = "\(counter)"
        } else if counter == 30 {
            print ("We're done here, boys")
            print (time)
            performSegue(withIdentifier: "exitClicker", sender: self)
        }
    }
    
}

