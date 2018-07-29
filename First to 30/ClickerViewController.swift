//
//  ViewController.swift
//  First to 30
//
//  Created by Daniel on 30/6/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

class ClickerViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    @IBOutlet var goLabel: UILabel!
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!
    var counter = 0
    var timer: Timer!
    var time = 0.0
    var timeCompleted: String = ""
    var numOfTapsRequired = 30
    var isAnimationOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(_) in
            self.time += 0.1
        })
        counterLabel.text = String(counter)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        counter = 0
        time = 0
        startButton.isHidden = true
        // Ready set go
        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: {
            self.goLabel.text = "READY"
            self.view.backgroundColor = .red
            self.goLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.goLabel.alpha = 0
        })
        animator.addCompletion{(_) in
            self.goLabel.transform = CGAffineTransform.identity
            self.goLabel.alpha = 1
            self.goLabel.text = "SET"
            self.view.backgroundColor = .yellow
            let secondAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations : {
                self.goLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.goLabel.alpha = 0
                
            })
            secondAnimator.addCompletion{(_) in
                self.goLabel.transform = CGAffineTransform.identity
                self.goLabel.alpha = 1
                self.goLabel.text = "GO!"
                self.view.backgroundColor = .green
                let thirdAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations : {
                    self.goLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
                    self.goLabel.alpha = 0
                    
                })
                thirdAnimator.addCompletion{(_) in
                    self.goLabel.alpha = 1
                    self.goLabel.transform = CGAffineTransform.identity
                    self.goLabel.isHidden = true
                    self.counterLabel.isHidden = false
                    self.counterLabel.text = "0"
                    self.isAnimationOver = true
                    self.hintLabel.isHidden = false
                    self.hintLabel.text = "Number of taps needed: \(self.numOfTapsRequired)"
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
                        self.time += 0.1
                    }
                }
                thirdAnimator.startAnimation()
            }
            secondAnimator.startAnimation()
        }
        
        animator.startAnimation()
    }
    override func viewDidAppear(_ animated: Bool) {
        goLabel.text = ""
        hintLabel.isHidden = true
        counterLabel.isHidden = true
        goLabel.isHidden = false
        view.backgroundColor = .red
        counter = 0
        time = 0
        timer?.invalidate()
        startButton.isHidden = false
        isAnimationOver = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func screenTapped(_ sender: Any) {
        if isAnimationOver == true {
            counter += 1
            counterLabel.text = "\(counter)"
        } else if isAnimationOver == false {
            print ("Sorry sir, restricted area.")
        }
        
        if counter == numOfTapsRequired {
            UIView.animate(withDuration: 0.5, animations: {
                self.timer?.invalidate()
                self.view.backgroundColor = .cyan
                self.counterLabel.text = "\(self.time)"
                // Label goes up
                let labelTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.counterLabel.transform = labelTransform
            }) { (_) in
                UIView.animate(withDuration: 0.5, animations: {
                    // Label goes back down
                    self.counterLabel.transform = CGAffineTransform.identity
                }) {(_) in
                    self.timeCompleted = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
                    self.performSegue(withIdentifier: "exitClicker", sender: self)
                }
            }
        }
    }
    
}

