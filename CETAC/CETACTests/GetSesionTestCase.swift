//
//  GetSesionTestCase.swift
//  CETACTests
//
//  Created by Annya Verduzco on 09/10/21.
//

import XCTest
@testable import CETAC

class GetSesionTestCase: XCTestCase {
    var sesionControlador = SesionesController()

   

    func testGetSesiones() throws {
        let exp = self.expectation(description: "testGetSesiones")
        sesionControlador.fetchSesiones("123") {
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
    
    func testGetSesionWrong() throws {
        let exp = self.expectation(description: "testGetSesionesWrong")
        sesionControlador.fetchSesiones("123"){ (result) in
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

