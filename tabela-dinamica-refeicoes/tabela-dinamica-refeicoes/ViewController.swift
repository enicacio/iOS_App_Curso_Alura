//
//  ViewController.swift
//  tabela-dinamica-refeicoes
//
//  Created by Eliane Regina Nicácio Mendes on 03/03/22.
//

import UIKit

class ViewController: UITableViewController {
    
    let refeicoes = ["Churros", "Macarrão", "Pizza"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableviewcontroller foi carregado")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    //Passar o conteúdo de cada posição do array para as linhas da tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao
        
        return celula
    }

}

