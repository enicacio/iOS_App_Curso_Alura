//
//  ItemDAO.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 08/07/22.
//

import Foundation

class ItemDAO {
    
    func save(_ itens: [Item]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: itens,
                requiringSecureCoding: false)
            guard let caminho = recuperaDiretorio() else { return }
            try data.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
        
    func recuperaListItens() -> [Item] {
        do {
            guard let diretory = recuperaDiretorio() else { return [] }
            let data = try Data(contentsOf: diretory)
            guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] else { return [] }
            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
        
    func recuperaDiretorio () -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in:
                .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("itens")
        
        return caminho
    }
}
