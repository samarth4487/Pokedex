//
//  PokemonMovesVC.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 18/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import TableViewPopoverPresenting
import Alamofire

class PokemonMovesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moves = [Dictionary<String, AnyObject>]()
    var movesDescription = "Downloading Data. Please be patient"
    var url = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateUI()
    }

    func updateUI() {
        
        //print(self.moves)
    }

    @IBAction func backButtonPressed(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.moves.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PokemonMovesCell", forIndexPath: indexPath) as? PokemonMovesCell {
            
            let move = moves[indexPath.row]
            cell.configureCell(move)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        url = "\(BASE_URL)\(moves[indexPath.row]["resource_uri"]!)"
        downloadMovesDescription {
            
            // Add a function update UI to display action sheet using that method!!!!
        }
        let actionSheet = UIAlertController(title: "Description", message: self.movesDescription, preferredStyle: .Alert)
        actionSheet.addAction(UIAlertAction(title: "Done", style: .Cancel) { _ in })
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func downloadMovesDescription(completed: DownloadComplete) {
        
        //print(self.url)
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            
            if let res = response.result.value as? Dictionary<String, AnyObject> {
                
                if let description = res["description"] as? String {
                    
                    //print(description)
                    self.movesDescription = description
                }
                //print(self.movesDescription)
            }
            
            completed()
        }
    }
    
}
