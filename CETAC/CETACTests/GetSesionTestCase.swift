//
//  GetSesionTestCase.swift
//  CETACTests
//
//  Created by Annya Verduzco on 09/10/21.
//

import XCTest
@testable import CETAC

class GetSesionTestCase: XCTestCase {
    var sesionControlador = SesionController()

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

    func testGetSesiones() throws {
        let exp = self.expectation(description: "teste")
        sesionControlador.fetchSesion() {
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
        let exp = self.expectation(description: "teste")
        sesionControlador.fetchSesion(){ (result) in
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

