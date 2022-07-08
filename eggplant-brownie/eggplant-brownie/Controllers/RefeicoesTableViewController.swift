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
    
    override func viewDidLoad() {
        guard let caminho = recuperaDiretorio() else { return }
        
        //Ler os dados salvos no armazenado
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeixoesSalvas = try
            NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as?
                    Array<Refeicao> else { return }
            refeicoes = refeixoesSalvas
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio () -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in:
                .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        return caminho
    }
    
    //Adicionar as refeições no array criado
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()// atualizar as refeições adicionadas pela tela viewcontroller
        
        guard let caminho = recuperaDiretorio() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
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
