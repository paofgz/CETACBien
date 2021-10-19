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


    func testCrearUsusario() throws {
        let exp2 = self.expectation(description: "testCrearUsusario")
        let now = Date()
        let newUser2 = Usuario(fecha: now, idTanatologo: "jess@miller.com", nombre: "testCase", ocupacion: "Estudiante", religion: "Ateo", procedencia: "Latino", domicilio: "Ciudad de México", telefonoDeCasa: "5546378273", celular: "55342234", estadoCivil: "Solterx", edadPareja: 20 , sexoPareja: "Mujer", hijos: "0", referido: "Juan", motivo: "Motivo", identificacionDeRespuesta: "Respuesta", EKR: "EKR", status: 1, proximaSesion: "20-10-2021 13:00", sexo: "Hombre", edad: 56)
        usuarioControlador.insertUsuario(nuevoUsuario: newUser2){
            (result)in
            switch result{
            case .success(let res):
                XCTAssertNotNil(res)
            case .failure(let err):
                XCTAssertNil(err)
            }
            exp2.fulfill()
        }
        self.waitForExpectations(timeout: 10.0)
    }
    
    func testCerrarUsuarioWrong() throws {
        let exp = self.expectation(description: "testCerrarUsuarioWrong")
        let now = Date()
        let newUser = Usuario(fecha: now, idTanatologo: "jess@miller.com", nombre: "", ocupacion: "Estudiante", religion: "Ateo", procedencia: "Latino", domicilio: "Ciudad de México", telefonoDeCasa: "5546378273", celular: "55342234", estadoCivil: "Solterx", edadPareja: 20 , sexoPareja: "Mujer", hijos: "0", referido: "Juan", motivo: "Motivo", identificacionDeRespuesta: "Respuesta", EKR: "EKR", status: 1, proximaSesion: "20-10-2021 13:00", sexo: "Hombre", edad: 56)
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
