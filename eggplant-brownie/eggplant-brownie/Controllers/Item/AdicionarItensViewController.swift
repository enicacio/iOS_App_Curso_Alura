//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Eliane Regina Nicácio Mendes on 09/03/22.
//

import UIKit

protocol AdicionaItensDelegate {
    func add (_ item: Item)
}

class AdicionarItensViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - Atributos
    
    var delegate: AdicionaItensDelegate?
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    //Implementação por causa da herança
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        
        //Extrair texto do textfield com verificação
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text else { return }
        
        //Casting calorias para Double com verificação
        guard let numeroDeCalorias = Double(calorias) else { return }
        
        let item = Item(nome: nome, calorias: numeroDeCalorias)
        
        //Verificar o delegate opcional chaining (if implicito)
        delegate?.add(item)
        
        navigationController?.popViewController(animated: true)
    }
}
