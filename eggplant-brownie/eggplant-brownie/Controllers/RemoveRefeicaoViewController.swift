//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 21/04/22.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    //Closure - função dentro de um método
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        //Controlador de Alerta
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        //Botões de interação usuário
        let botaoCancelar = UIAlertAction(title: "Ok", style: .cancel)
        alerta.addAction(botaoCancelar)
        
        //Botão de remover
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        
        alerta.addAction(botaoRemover)
        
        //Exibir balão do alerta
        controller.present(alerta, animated: true, completion: nil)
    }
}
