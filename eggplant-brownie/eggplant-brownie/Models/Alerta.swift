//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 21/04/22.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init (controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(titulo: String = "Atenção", mensagem: String) {
        //"Atenção" é o valor default do método
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
