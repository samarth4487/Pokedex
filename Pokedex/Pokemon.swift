//
//  Pokemon.swift
//  Pokedex
//
//  Created by Samarth Paboowal on 16/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _pokeDescription: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    private var _evolutionText: String!
    private var _evolutionName: String!
    private var _evolutionID: String!
    private var _evolutionLevel: String!
    private var _pokemonURL: String!
    
    var name: String {
        
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    var pokemonDescription: String {
        
        if _pokeDescription == nil {
            _pokeDescription = ""
        }
        return _pokeDescription
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var evolutionLevel: String {
        
        if _evolutionLevel == nil {
            _evolutionLevel = ""
        }
        return _evolutionLevel
    }
    
    var evolutionID: String {
        
        if _evolutionID == nil {
            _evolutionID = ""
        }
        return _evolutionID
    }
    
    var evolutionName: String {
        
        if _evolutionName == nil {
            _evolutionName = ""
        }
        return _evolutionName
    }
    
    var evolutionText: String {
        
        if _evolutionText == nil {
            _evolutionText = ""
        }
        return _evolutionText
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self._pokedexID)/"
        
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        
        Alamofire.request(.GET, self._pokemonURL).responseJSON { (response) in
            
            if let mainDict = response.result.value as? Dictionary<String, AnyObject> {
                
                //MARK:- ATTACK
                if let attack = mainDict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                //MARK:- DEFENSE
                if let defense = mainDict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                //MARK:- HEIGHT
                if let height = mainDict["height"] as? String {
                    
                    self._height = height
                }
                
                //MARK:- WEIGHT
                if let weight = mainDict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                //print(self._weight)
                //print(self._height)
                //print(self._attack)
                //print(self._defense)
                
                //MARK:- DESCRIPTION
                if let description = mainDict["descriptions"] as? [Dictionary<String, String>] where description.count > 0 {
                    
                    if let url = description[0]["resource_uri"] {
                        
                        let fullURL = "\(BASE_URL)\(url)"
                        Alamofire.request(.GET, fullURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.stringByReplacingOccurrencesOfString("POKMON", withString: "Pokemon")
                                    
                                    self._pokeDescription = newDescription
                                    //print(self._pokeDescription)
                                }
                            }
                            
                            completed()
                        })
                    }
                    
                } else {
                    
                    self._pokeDescription = ""
                }
                
                //MARK:- TYPE
                if let types = mainDict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    //print(self._type)
                    
                } else {
                    
                    self._type = ""
                }
                
                //MARK:- EVOLUTIONS
                if let evolutions = mainDict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.rangeOfString("mega") == nil {
                            
                            self._evolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let nextEvoId = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._evolutionID = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] as? Int {
                                    
                                    self._evolutionLevel = "\(lvlExist)"
                                    
                                } else {
                                    
                                    self._evolutionLevel = ""
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    //print(self.evolutionLevel)
                    //print(self.evolutionName)
                    //print(self.evolutionID)
                }
                
            }
            
            completed()
        }
    }
}