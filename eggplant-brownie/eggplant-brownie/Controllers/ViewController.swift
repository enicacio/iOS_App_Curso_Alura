//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 20/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nomeTextFiel: UITextField?
    @IBOutlet var felicidadeTextFiel: UITextField?
    
    @IBAction func adicionar(_ sender: Any) {
        
        guard let nomeDaRefeicao = nomeTextFiel?.text else {
            return
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextFiel?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade)
        
        print("comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")
    }
}

