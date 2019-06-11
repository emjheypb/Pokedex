//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mariah Baysic on 10/06/2019.
//  Copyright © 2019 SpacedOut. All rights reserved.
//

class Pokemon {
    private(set) public var name: String
    private(set) public var image: Any
    
    init(name: String, image: Any) {
        self.name = name
        self.image = image
    }
    
    func setImage(image: Any) {
        self.image = image
    }
    
}
