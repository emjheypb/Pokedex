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

class HomeController: UITableViewController {
    
    var arrayPokedexNames = [String]()
    var pokedex : Pokedex?
    var pokeAPI : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessPokeAPI(url: apiURL + "pokedex")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexCell else { return UITableViewCell() }
        
        cell.initCell(name: arrayPokedexNames[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPokedexNames.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokedex = Pokedex(name: arrayPokedexNames[indexPath.row], index: indexPath.row)
        performSegue(withIdentifier: "goToPokedex", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokedex" {
            let destinationVC = segue.destination as! PokedexController
            
            destinationVC.pokedex = pokedex
        }
    }
    
    func accessPokeAPI(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let pokeJSON: JSON = JSON(response.result.value!)
                    self.setPokedexArray(pokeJSON: pokeJSON)
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }
    
    func setPokedexArray(pokeJSON: JSON) {
        for pokedexName in pokeJSON["results"].arrayValue {
            var tempPokedexName = ""
            
            if let name = pokedexName["name"].string {
                if name.contains("-") {
                    for tempName in name.split(separator: "-") {
                        tempPokedexName += tempName.prefix(1).uppercased() + tempName.suffix(tempName.count - 1) + " "
                    }
                } else {
                    tempPokedexName = name.prefix(1).uppercased() + name.suffix(name.count - 1)
                }
                
                arrayPokedexNames.append(tempPokedexName.trimmingCharacters(in: .whitespaces))
            }
        }
        
        tableView.reloadData()
    }
}
