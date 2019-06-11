//
//  HomeController.swift
//  Pokedex
//
//  Created by Mariah Baysic on 10/06/2019.
//  Copyright © 2019 SpacedOut. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PokedexController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var arrayPokemon = [Pokemon]()
    var pokedex : Pokedex!
    var jsonURL : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pokedex.name
        accessPokeAPI(url: apiURL + "pokedex/" + String(pokedex.index + 1))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else { return UITableViewCell() }
        
//        cell.initCell(name: arrayPokemon[indexPath.row].name, image: arrayPokemon[indexPath.row].imageURL)
        
        cell.pokemonName.text = arrayPokemon[indexPath.row].name
        cell.pokemonImage.image = arrayPokemon[indexPath.row].image as? UIImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPokemon.count
    }
    
    func accessPokeAPI(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let pokeJSON: JSON = JSON(response.result.value!)
                    
                    self.setPokemonArray(pokeJSON: pokeJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
        
    }
    
    func setPokemonArray(pokeJSON: JSON) {
        for pokemon in pokeJSON["pokemon_entries"].arrayValue {
            let name = pokemon["pokemon_species"]["name"].string!
            let pokemonURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemon["pokemon_species"]["url"].string!.split(separator: "/")[5] +  ".png"
            
            arrayPokemon.append(Pokemon(name: name.prefix(1).uppercased() + name.suffix(name.count - 1), image: UIImage(named: "poke-ball") as Any))
            
            let imageURL = URL(string: pokemonURL)!
            downloadImage(from: imageURL, index: arrayPokemon.count - 1)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, index: Int) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
//                self.pokemonImage.image = UIImage(data: data)
                self.arrayPokemon[index].setImage(image: UIImage(data: data) as Any)
                self.tableView.reloadData()
            }
        }
    }
}
