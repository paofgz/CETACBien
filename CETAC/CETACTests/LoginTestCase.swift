//
//  LoginTestCase.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest
@testable import CETAC


class LoginTestCase: XCTestCase {
    var loginController = LoginController()

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
    
    func testLogin() throws {
        let exp = self.expectation(description: "teste")
        loginController.logIn(passwordClean: "Jess1234@", emailClean: "jess@miller.com"){ (result) in
            switch result{
            case .success(let email): self.loginController.isAdministrator(email: email){
                    (tmp)in
                XCTAssertEqual(tmp, "tanatologoInicial")
                }
            case .failure(let err): XCTAssertNil(err)
            }
            exp.fulfill()

        }
        
        self.waitForExpectations(timeout: 5.0)
    }
    func testLoginWrong() throws {
        let exp = self.expectation(description: "teste")
        loginController.logIn(passwordClean: "NewPass1234%", emailClean: "email@random.mx"){ (result) in
            switch result{
            case .success(let email): self.loginController.isAdministrator(email: email){
                    (tmp)in
                XCTAssertEqual(tmp, "t")
                }
            case .failure(let err): XCTAssertNotNil(err)
            }
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
