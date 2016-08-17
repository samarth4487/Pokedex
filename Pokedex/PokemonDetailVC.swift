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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pokedexLabel.text = "\(pokemon.pokedexID)"
        nameLabel.text = pokemon.name.capitalizedString
        let image = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = image
        firstImage.image = image
        
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        
        self.descriptionLabel.text = pokemon.pokemonDescription
        self.typeLabel.text = pokemon.type
        self.heightLabel.text = pokemon.height
        self.weightLabel.text = pokemon.weight
        self.attackLabel.text = pokemon.attack
        self.defenseLabel.text = pokemon.defense
        
        if pokemon.evolutionName != "" {
            
            if pokemon.evolutionLevel != "" {
                
                self.evolutionLabel.text = "Next Evolution: \(pokemon.evolutionName.capitalizedString) LVL \(pokemon.evolutionLevel)"
                let image = UIImage(named: "\(pokemon.evolutionID)")
                secondImage.image = image
            } else {
                
                self.evolutionLabel.text = "Next Evolution: \(pokemon.evolutionName.capitalizedString)"
                let image = UIImage(named: "\(pokemon.evolutionID)")
                secondImage.image = image
            }
            
        } else {
            
            self.evolutionLabel.text = "No Next Evolution"
            secondImage.image = nil
        }
    }

    @IBAction func backButtonPressed(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
