//
//  MainController.swift
//  Pokedex
//
//  Created by Mariah Baysic on 10/06/2019.
//  Copyright © 2019 SpacedOut. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewPokedex: UITableView!
    
    let baseURL = "https://pokeapi.co/api/v2/"
    
    var pokedexArray = ["Kanto","Johto"]
    var finalURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewPokedex.delegate = self
        tableViewPokedex.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexCell else { return UITableViewCell() }
        
        cell.initCell(name: pokedexArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexArray.count
    }
    
}

