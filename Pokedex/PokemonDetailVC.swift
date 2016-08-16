//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 16/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalizedString
    }

    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
