//
//  ViewController.swift
//  First to 30
//
//  Created by Daniel on 30/6/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class ClickerViewController: UIViewController {

    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!
    var counter = 0
    var timer: Timer!
    var time = 0.0
    var timeCompleted: String = ""
    var numOfTapsRequired = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(_) in
            self.time += 0.1
        })
        counterLabel.text = String(counter)
        hintLabel.text = "Number of taps needed: \(numOfTapsRequired)"
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func screenTapped(_ sender: Any) {
        if counter < numOfTapsRequired {
        counter += 1
        counterLabel.text = "\(counter)"
        } else if counter == numOfTapsRequired {
            timeCompleted = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
            performSegue(withIdentifier: "exitClicker", sender: self)
        }
    }
    
}

