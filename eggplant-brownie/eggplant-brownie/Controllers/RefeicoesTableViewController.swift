//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 03/03/22.
//

import Foundation
import UIKit

class RefeicoesTableViewController: UITableViewController, RefeicoesAddControllerDelegate {
    
    var refeicoes = [Refeicao(nome: "Macarrão", felicidade: 2),
                     Refeicao(nome: "Pizza", felicidade: 4),
                     Refeicao(nome: "Comida Japonesa", felicidade: 5)]
    
    
    //Adicionar as refeições no array criado
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()// atualizar as refeições adicionadas pela tela viewcontroller
    }
    
    //Trabalhando com segue no Storyboard - Acoplado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //identificador de segue como boa prática
        if segue.identifier == "adicionarRefeicao" {
            if let view = segue.destination as? RefeicoesAddController {
                view.delegate = self
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    //Quantas linhas vão ter na tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let refeicao = refeicoes[indexPath.row]
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        celula.textLabel?.text = refeicao.nome //Colocar a label de texto para dentro da célula
        
        //Long Press do usuário
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    // MARK: - LongPress Detail
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began { //detalhar longpress apenas no estado inicial
            let celula = gesture.view as! UITableViewCell
            
            //Extrair os valores da celula com segurança
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            
            //Guarda os dados extraídos em uma constante
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    
    
    
    
    
}
