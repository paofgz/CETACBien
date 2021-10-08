//
//  ValidatorsTestCase.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest
@testable import CETAC

class ValidatorsTestCase: XCTestCase {
    var validators = Validators()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // isPasswordValid
    func testValidPass() throws {
        let res = validators.isPasswordValid("abcde151%")
        XCTAssertTrue(res)

    }
    func testShortPass() throws {
        let res = validators.isPasswordValid("abp/1")
        XCTAssertFalse(res)

    }
    func testNumbersPass() throws {
        let res = validators.isPasswordValid("12345%789")
        XCTAssertFalse(res)

    }
    func testLettersPass() throws {
        let res = validators.isPasswordValid("abkck@jsjfolfs")
        XCTAssertFalse(res)

    }
    //isValidEmail
    func testEmail() throws {
        let res = validators.isValidEmail("abc@gmail.com")
        XCTAssertTrue(res)
    }
    func testShortEmail() throws {
        let res = validators.isValidEmail("a@g.c")
        XCTAssertFalse(res)
    }
    func testWrongEmail() throws {
        let res = validators.isValidEmail("xyz@abc")
        XCTAssertFalse(res)
    }
    func testWrongEmail2() throws {
        let res = validators.isValidEmail("xyz.abc")
        XCTAssertFalse(res)
    }
    // isValidName
    func testName() throws {
        let res = validators.isValidName("Jaime")
        XCTAssertTrue(res)
    }
    func testNameNumber() throws {
        let res = validators.isValidName("Jaime123")
        XCTAssertFalse(res)
    }
    func testNameShort() throws {
        let res = validators.isValidName("a")
        XCTAssertFalse(res)
    }
    func testNameSpecialChar() throws {
        let res = validators.isValidName("a%Z")
        XCTAssertFalse(res)
    }
    //validateFieldsLogin
    
    func testValidateFields() throws {
        let res = validators.validateFields(correoText: "example@correo.fr", passwordText: "123abcde$")
        XCTAssertNil(res)
    }
    func testValidateFieldsWrongEmail() throws {
        let res = validators.validateFields(correoText: "ex", passwordText: "123abcde$")
        XCTAssertEqual("Ponga un email correcto", res)
    }
    func testValidateFieldsWrongPass() throws {
        let res = validators.validateFields(correoText: "example@correo.fr", passwordText: "abc")
        XCTAssertEqual( "Ponga una contraseña segura, mínimo 8 caracteres, y 1 caracter especial", res)
    }
    //.validateFields(nombreText:nombreText.text!, apellidoText:apelllidoText.text!,correoText:correoText.text!,passwordText:passwordText.text!)
    func testValidateFieldsSignUp() throws {
        let res = validators.validateFields(nombreText:"Alberto", apellidoText:"Carmona Pérez",correoText: "alberto@email.com",passwordText:"betito163@")
        XCTAssertNil( res)
    }
    func testValidateFieldsSignUpWrongName() throws {
        let res = validators.validateFields(nombreText:"A124%", apellidoText:" Pérez",correoText: "alberto@email.com",passwordText:"betito163@")
        XCTAssertEqual( "Ponga un nombre válido", res)
    }
    func testValidateFieldsNulls() throws {
        let res = validators.validateFields(nombreText:"", apellidoText:"",correoText: "",passwordText:"")
        XCTAssertEqual( "Llene todos los campos", res)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
