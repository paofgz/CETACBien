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

    func testFetchAdmin() throws {
        let exp = self.expectation(description: "testFetchAdmin")
        perfilController.fetchPerfil(email: "juan@gmail.com", perfil: "Administradores"){
            (tmp)in
            XCTAssertTrue(tmp == "Juan Gutierrez")
        
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testFetchTanatologo() throws {
        let exp = self.expectation(description: "testFetchTanatologo")
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
