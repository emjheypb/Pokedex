//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Mariah Baysic on 10/06/2019.
//  Copyright © 2019 SpacedOut. All rights reserved.
//

import UIKit

class PokedexCell: UITableViewCell {
//    @IBOutlet weak var pokedexImage: UIImageView!
    @IBOutlet weak var pokedexName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func configureCell(image: UIImage, name: String) {
//        pokedexImage.image = image
//        pokedexName.text = name
//    }
    
    func initCell(name: String) {
        pokedexName.text = name
    }
    
}
