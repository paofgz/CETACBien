//
//  CrearSesionesTestCase.swift
//  CETACTests
//
//  Created by Annya Verduzco on 10/10/21.
//

import XCTest
@testable import CETAC

class CrearSesionesTestCase: XCTestCase {
    var SesionControlador = SesionesController()

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

    func testCrearSesion() throws {
        let exp = self.expectation(description: "teste")
        let newSesion = Sesion(fecha:"", herramienta: "Contención", tipoDeIntervencion: "Tanatología", evaluacionSesion:"Bien", servicio: "Servicio de acompañamiento", cuotaDeRecuperacion: 0.0, cerrarExpediente: true)
        SesionControlador.insertSesion(idUsuario: "123", nuevaSesion:newSesion){
            (result)in
            switch result{
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err):
                XCTAssertNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }
    
}

