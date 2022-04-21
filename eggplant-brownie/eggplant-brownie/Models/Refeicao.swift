//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 20/01/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    
    // MARK: - Atributos
    
    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    // MARK: - Init/Construtor
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    //MARK: - NSCoding
    
    //serialização
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(felicidade, forKey: "felicidade")
        aCoder.encode(itens, forKey: "itens")
    }
    
    //deserialização
    required init?(coder aDecorder: NSCoder) {
        nome = aDecorder.decodeObject(forKey: "nome") as! String
        felicidade = aDecorder.decodeInteger(forKey: "felicidade")
        itens = aDecorder.decodeObject(forKey: "itens") as! Array<Item>
    }
    
    // MARK: - Métodos
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        return total
    }
    
    func detalhes() -> String {
        //Mensagem personalizada da mensagem de alerta
        var mensagem = "Felicidade: \(felicidade)"
        for item in itens {
            mensagem += ", \(item.nome) - Calorias: \(item.calorias)"
        }
        
        return mensagem
    }
}
