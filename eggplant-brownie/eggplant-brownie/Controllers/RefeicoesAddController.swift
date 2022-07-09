//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 20/01/22.
//

import UIKit

//Protocol equivale a interface
protocol RefeicoesAddControllerDelegate {
    func add(_ refeicao: Refeicao) //Casca do método, a implementação fica com a classe
}

class RefeicoesAddController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {

    // MARK: - IBOutlets

    @IBOutlet var nomeTextFiel: UITextField?
    @IBOutlet weak var felicidadeTextFiel: UITextField?
    @IBOutlet weak var itensTableView: UITableView?
    
    
    // MARK: - Variaveis
    
    var delegate: RefeicoesAddControllerDelegate?
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    //Separando as responsabilidades que estão no método de adicionar
    func recuperaRefeicaodoFormulario() -> Refeicao? {
        
        guard let nomeDaRefeicao = nomeTextFiel?.text else {
            Alerta(controller: self).exibe(mensagem: "Digite o nome da Refeição")
            return nil
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextFiel?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            Alerta(controller: self).exibe(mensagem: "Digite o valor da felicidade")
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
    
        return refeicao
    }
    
    // MARK: - IBAction
    
    @IBAction func add(_ sender: Any) {
        guard let refeicao = recuperaRefeicaodoFormulario() else {
            return Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulário")
        }
        delegate?.add(refeicao) //Relacionar os itens selecionados com a refeição
        navigationController?.popViewController(animated: true) //Navegar entre as telas
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itens[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = item.nome
        
        return cell
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Novo Item", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        recuperaItens()
    }
    
    func recuperaItens() {
        itens = ItemDAO().recuperaListItens()
    }
    
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDAO().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibe(mensagem: "Não foi possível atualizar a tabela")
        }
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.delegate = self
        
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        //dar o check na célula selecionada
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            celula.tintColor = .red //Mudar o checkmark de cor
            
            //Salvar o item selecionado no array
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])

        } else {
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
            }
        }
    }
}

