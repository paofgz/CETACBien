//
//  CETACTests.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest

@testable import CETAC



class CETACTests: XCTestCase {
    var prueba = LoginController()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        
       let exp = self.expectation(description: "teste")
        
        prueba.isAdministrator(email: "jess@miller.com"){
            (tmp)in
    
            XCTAssertTrue(tmp == "tanatologoInicial")
            //tanatologoInicial
            //inicialAdmin
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 30.0)
    }
 

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
