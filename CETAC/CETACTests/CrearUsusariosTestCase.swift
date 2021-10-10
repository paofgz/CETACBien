//
//  CrearUsusariosTestCase.swift
//  CETACTests
//
//  Created by Paola Fernández on 09/10/21.
//

import XCTest
@testable import CETAC

class CrearUsusariosTestCase: XCTestCase {
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

    func testCrearUsusario() throws {
        let exp = self.expectation(description: "teste")
        let newUser = Usuario(fecha: "09-10-2021 13:12", idTanatologo: "jess@miller.com", nombre: "testCase", ocupacion: "Estudiante", religion: "Ateo", procedencia: "Latino", domicilio: "Ciudad de México", telefonoDeCasa: "5546378273", celular: "55342234", estadoCivil: "Solterx", edadPareja: 20 , sexoPareja: "Mujer", numeroDeHijos: 0, edadesHijos: "", sexoHijos: "", referido: "Juan", motivo: "Motivo", identificacionDeRespuesta: "Respuesta", EKR: "EKR", status: 1, proximaSesion: "20-10-2021 13:00")
        usuarioControlador.insertUsuario(nuevoUsuario: newUser){
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
    
    func testCerrarExpedienteWrong() throws {
        let exp = self.expectation(description: "teste")
        let newUser = Usuario(fecha: "09-10-2021 13:12", idTanatologo: "jess@miller.com", nombre: "", ocupacion: "Estudiante", religion: "Ateo", procedencia: "Latino", domicilio: "Ciudad de México", telefonoDeCasa: "5546378273", celular: "55342234", estadoCivil: "Solterx", edadPareja: 20 , sexoPareja: "Mujer", numeroDeHijos: 0, edadesHijos: "", sexoHijos: "", referido: "Juan", motivo: "Motivo", identificacionDeRespuesta: "Respuesta", EKR: "EKR", status: 1, proximaSesion: "20-10-2021 13:00")
        usuarioControlador.insertUsuario(nuevoUsuario: newUser){ (result) in
            switch result{
            case .success(let res):
                XCTAssertEqual(res, "El usuario debe tener un nombre")
            case .failure(let err): XCTAssertNil(err)
            }
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 5.0)
    }

}
