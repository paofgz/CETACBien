//
//  GetUsuariosTestCase.swift
//  CETACTests
//
//  Created by Paola Fernández on 09/10/21.
//

import XCTest
@testable import CETAC

class GetUsuariosTestCase: XCTestCase {
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

    func testGetUsuarios() throws {
        let exp = self.expectation(description: "test to get all users")
        usuarioControlador.fetchUsuarios() {
            (result)in
            switch result{
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err): XCTAssertNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testGetUsuariosWrong() throws {
        let exp = self.expectation(description: "test to get all users wrong")
        usuarioControlador.fetchUsuarios(){ (result) in
            switch result{
            case .success(let res):
                XCTAssertNil(res)
            case .failure(let err): XCTAssertNotNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }

}
