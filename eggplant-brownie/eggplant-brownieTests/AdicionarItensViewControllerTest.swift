//
//  AdicionarItensViewControllerTest.swift
//  eggplant-brownieTests
//
//  Created by Eliane Regina Nicácio Mendes on 20/07/22.
//

import XCTest
@testable import eggplant_brownie

class AdicionarItensViewControllerTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdicionarItens() {
        var nometextFieldTest: String = "Açai"
        var caloriasTextFieldTest = 0.0
        
        let itemAdicionado = Item(nome: nometextFieldTest, calorias: caloriasTextFieldTest)
        let itemExemplo = Item(nome: "Açai", calorias: 0.0)
        
        XCTAssertNotNil(itemAdicionado)
//        XCTAssertEqual(itemExemplo, itemAdicionado)
        
    }

    

}
