//
//  SingUpTestCase.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest
@testable import CETAC
class SingUpTestCase: XCTestCase {
     var singUpController = SingUpController()
    
    func testSignUpNotAdmin() throws {
        let exp = self.expectation(description: "testSignUpNotAdmin")
        singUpController.dbIsAdmin(email: "john@does.com"){
            (tmp)in
            XCTAssertFalse(tmp)
        
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
    func testSignUpIsAdmin() throws {
        let exp = self.expectation(description: "testSignUpIsAdmin")
        
        singUpController.dbIsAdmin(email: "jimmy@jones.con"){
            (tmp)in
            XCTAssertTrue(tmp)
        
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
