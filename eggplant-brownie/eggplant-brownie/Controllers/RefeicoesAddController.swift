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
    @IBOutlet weak var itensTableView: UITableView!
    
    
    // MARK: - Variaveis
    
    var delegate: RefeicoesAddControllerDelegate?
    var itens: [Item] = [Item(nome: "Molho de tomate", calorias: 40.0),
                         Item(nome: "Queijo", calorias: 40.0),
                         Item(nome: "Manjericão", calorias: 40.0),
                         Item(nome: "Ketchup", calorias: 40.0)]
    
    //Salvar os itens selecionados
    var itensSelecionados: [Item] = []
    
    
    // MARK: - IBAction
    
    @IBAction func add(_ sender: Any) {
        
        guard let nomeDaRefeicao = nomeTextFiel?.text else {
            return
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextFiel?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        //Relacionar os itens selecionados com a refeição
        refeicao.itens = itensSelecionados
        
        print("comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")
        
        delegate?.add(refeicao)
        
        //Navegar entre as telas
        navigationController?.popViewController(animated: true)
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
    
    // MARK: - UITableViewDelegate
    
    //Enxergar o que o usuário está selecionando na tela
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
            
            //Achar a posição do elemento
            let item = itens[indexPath.row]
            
            //Procurar o elemento na posição encontrada
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
                
                //Teste para saber se removeu corretamente da lista
//                for itemSelecionado in itensSelecionados {
//                    print(itemSelecionado.nome)
//                }
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    //Botão Add itens
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Novo Item", style: .plain, target: self, action: #selector(adicionarItem))
        
        //Adiciona o botão na barra de navegação
        navigationItem.rightBarButtonItem = botaoAdicionaItem
    }
    
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
        
    }
    
    
    
}

