//
//  CerrarExpedienteTestcase.swift
//  CETACTests
//
//  Created by Paola Fernández on 09/10/21.
//

import XCTest
@testable import CETAC

class CerrarExpedienteTestCase: XCTestCase {
    var usuarioControlador = UsuarioController()

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
    
    func testCerrarExpediente() throws {
        let exp = self.expectation(description: "test to close the user record")
        usuarioControlador.updateUser(usuarioId: "gx4v8HdbuG2Ugoc2nThK", status: 0, numSes: 23, lastSes: Date()){
            (result)in
            switch result{
            case .success(let res):
                XCTAssertEqual(res, "Document successfully updated")
            case .failure(let err): XCTAssertNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testCerrarExpedienteWrong() throws {
        let exp = self.expectation(description: "test to close the user record wrong")
        usuarioControlador.updateUser(usuarioId: "gx4v8HdbuG2Ugoc2nT", status: 0, numSes: 23, lastSes: Date()){ (result) in
            switch result{
            case .success(let res):
                XCTAssertEqual(res, "Doc")
            case .failure(let err): XCTAssertNotNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }

}
