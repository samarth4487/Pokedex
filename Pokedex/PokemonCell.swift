//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 16/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        self.nameLabel.text = pokemon.name
        self.thumbImg.image = UIImage(named: "\(pokemon.pokedexID)")
        
    }
}
