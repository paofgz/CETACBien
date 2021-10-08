//
//  PefilTestCase.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest
@testable import CETAC

class PefilTestCase: XCTestCase {
    var perfilController = PerfilController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFetchAdmin() throws {
        let exp = self.expectation(description: "teste")
        perfilController.fetchPerfil(email: "juan@gmail.com", perfil: "Administradores"){
            (tmp)in
            XCTAssertTrue(tmp == "Juan Gutierrez")
        
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testFetchTanatologo() throws {
        let exp = self.expectation(description: "teste")
        perfilController.fetchPerfil(email: "pedro@hotmail.com", perfil: "Tanatologo"){
            (tmp)in
            XCTAssertTrue(tmp == "Pedro Zárate Ocaña")
        
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
