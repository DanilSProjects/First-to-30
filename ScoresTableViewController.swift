//
//  ScoresTableViewController.swift
//  First to 30
//
//  Created by Daniel on 30/6/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit

private let SAVED_SCORES_KEY = "savedScores"
private let SAVED_TIMES_KEY = "savedTimes"
class ScoresTableViewController: UITableViewController {
    
    var scores: [Float] = []
    var timeStamps: [String] = []
    var noOfTapsRequired = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadedScores = UserDefaults.standard.array(forKey: SAVED_SCORES_KEY)
        let loadedTimes = UserDefaults.standard.array(forKey: SAVED_TIMES_KEY)
        scores = loadedScores as? [Float] ?? [Float]()
        timeStamps = loadedTimes as? [String] ?? [String]()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
/*
        self.navigationItem.leftBarButtonItem = self.editButtonItem
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        UserDefaults.standard.set(scores, forKey: SAVED_SCORES_KEY)
        UserDefaults.standard.set(timeStamps, forKey: SAVED_TIMES_KEY)
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableViewCell
        if let label = cell.textLabel {
            let currentScore = scores[indexPath.row]
            label.text = "\(currentScore) seconds"
        }
        
        if let timeLabel = cell.timeStampLabel {
            let currentTimeStamp = timeStamps[indexPath.row]
            timeLabel.text = currentTimeStamp
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timeStamps.remove(at: indexPath.row)
            scores.remove(at: indexPath.row)
            UserDefaults.standard.set(scores, forKey: SAVED_SCORES_KEY)
            UserDefaults.standard.set(timeStamps, forKey: SAVED_TIMES_KEY)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playClicker" {
            let destination = segue.destination as! ClickerViewController
            destination.numOfTapsRequired = noOfTapsRequired
        }
    }
    
    
    @IBAction func unwindToScoreTable (segue: UIStoryboardSegue) {
        if segue.identifier == "exitClicker" {
            let source = segue.source as! ClickerViewController
            scores.insert((Float(source.time)), at: 0)
            timeStamps.insert(source.timeCompleted, at: 0)
            UserDefaults.standard.set(scores, forKey: SAVED_SCORES_KEY)
            UserDefaults.standard.set(timeStamps, forKey: SAVED_TIMES_KEY)
            tableView.reloadData()
        }
        
        if segue.identifier == "saveUnwind" {
            scores.removeAll()
            timeStamps.removeAll()
            UserDefaults.standard.set(scores, forKey: SAVED_SCORES_KEY)
            UserDefaults.standard.set(timeStamps, forKey: SAVED_TIMES_KEY)
            tableView.reloadData()
        }
        
    }

}
