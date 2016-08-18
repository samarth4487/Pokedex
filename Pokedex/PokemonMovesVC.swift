//
//  PokemonMovesVC.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 18/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class PokemonMovesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moves = [Dictionary<String, AnyObject>]()
    
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
}
