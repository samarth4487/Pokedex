//
//  PokemonMovesCell.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 18/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class PokemonMovesCell: UITableViewCell {

    @IBOutlet weak var moveLabel: UILabel!
    
    func configureCell(move: Dictionary<String, AnyObject>) {
        
        self.moveLabel.text = "\(move["learn_type"]!): \(move["name"]!)"
    }
}
