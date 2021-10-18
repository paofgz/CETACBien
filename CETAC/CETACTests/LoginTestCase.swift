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
    
    func testLoginTanatologo() throws {
        let exp = self.expectation(description: "LoginTestCase")
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
        let exp = self.expectation(description: "testLoginWrong")
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
    
    func testLoginAdmin() throws {
        let exp = self.expectation(description: "testLoginAdmin")
        loginController.logIn(passwordClean: "Jimmy1234@", emailClean: "jimmy@jones.con"){ (result) in
            switch result{
            case .success(let email): self.loginController.isAdministrator(email: email){
                    (tmp)in
                XCTAssertEqual(tmp, "inicialAdmin")
                }
            case .failure(let err): XCTAssertNil(err)
            }
            exp.fulfill()

        }
        
        self.waitForExpectations(timeout: 5.0)
    }
    

}
