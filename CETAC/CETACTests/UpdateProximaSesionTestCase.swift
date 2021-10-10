//
//  UpdateProximaSesionTestCase.swift
//  CETACTests
//
//  Created by Paola Fernández on 09/10/21.
//

import XCTest
@testable import CETAC

class UpdateProximaSesionTestCase: XCTestCase {
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
    
    func testUpdateProximaSesion() throws {
        let exp = self.expectation(description: "test to update next sesion")
        usuarioControlador.updateProxSes(usuarioId: "gx4v8HdbuG2Ugoc2nThK", proxSes: "20-10-2021 18:30") {
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
    
    func testUpdateProximaSesionWrong() throws {
        let exp = self.expectation(description: "test to update next sesion")
        usuarioControlador.updateProxSes(usuarioId: "gx4v8HdbuG2Ugoc2nT", proxSes: "20-10-2021 18:30"){ (result) in
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
