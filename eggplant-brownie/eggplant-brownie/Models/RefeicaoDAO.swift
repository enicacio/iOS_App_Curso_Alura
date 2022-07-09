//
//  RefeicaoDAO.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 08/07/22.
//

import Foundation

class RefeicaoDAO {
    
    func save(_ refeicoes: [Refeicao]) {
        guard let caminho = recuperaDiretorio() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaList() -> [Refeicao] {
        guard let caminho = recuperaDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeixoesSalvas = try
            NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as?
                    Array<Refeicao> else { return [] }
            
            return refeixoesSalvas
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recuperaDiretorio () -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in:
                .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        return caminho
    }
}
