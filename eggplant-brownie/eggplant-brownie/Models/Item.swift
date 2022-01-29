//
//  Item.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 20/01/22.
//

import UIKit

class Item: NSObject {
    
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
