//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Mariah Baysic on 10/06/2019.
//  Copyright © 2019 SpacedOut. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PokemonCell: UITableViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
