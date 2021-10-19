//
//  CuotasController.swift
//  CETAC
//
//  Created by Paola Fernández on 16/10/21.
//
import Foundation
import Firebase
import UIKit

class CuotasController {
    let db = Firestore.firestore()
    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var tanatologoControlador = TanatologoController()
    ///
    var motivoController = MotivoController()
    ///
    
    func fetchCuotasGlobales(fechaInicio: Date, fechaFin: Date, completion: @escaping (Result<Double, Error>) -> Void){
        
        var cuota = 0.0
        let group = DispatchGroup()
        ////cambio
        self.motivoController.fetchUsuarios(fechaInicio: fechaInicio, fechaFinal: fechaFin){ (result) in
            switch result{
            case .success(let usuarios):
                for usuario in usuarios {
                    group.enter()
                    self.sesionControlador.fetchSesiones(usuario.id){
                        (res) in
                        switch res{
                        case .success(let sesiones):
                            for sesion in sesiones{
                                cuota += Double(sesion.cuotaDeRecuperacion)
                            }
                        case .failure(let error): print("No se pudo acceder a las sesiones, Error: \(error)")
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    print("Cuota global: \(cuota)")
                    completion(.success(cuota))
                }
            case .failure(let error):
                print("No se pudo acceder a los usuarios, Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchCuotasByTan(fechaInicio: Date, fechaFin: Date, completion: @escaping (Result<[String: Double], Error>) -> Void) {
        print("In")
        let group1 = DispatchGroup()
        var cuotasTan = [String: Double]()
        tanatologoControlador.fetchTanatologo() {
            (result) in
            switch result{
            case .success(let tanatologos):
                for tanatologo in tanatologos{
                    cuotasTan[tanatologo.nombre] = 0.0
                }
                for tanatologo in tanatologos{
                    group1.enter()
                    self.motivoController.fetchUsuariosByTan(idTan: tanatologo.correo, fechaInicio: fechaInicio, fechaFinal: fechaFin){
                        (res) in
                        switch res{
                        case .success(let usuarios):
                            for usuario in usuarios {
                                group1.enter()
                                self.sesionControlador.fetchSesiones(usuario.id){
                                    (res) in
                                    switch res{
                                    case .success(let sesiones):
                                        for sesion in sesiones{
                                            cuotasTan[tanatologo.nombre]! += Double(sesion.cuotaDeRecuperacion)
                                        }
                                    case .failure(let error): print("No se pudo acceder a las sesiones, Error: \(error)")
                                    }
                                    group1.leave()
                                }
                            }
                        case.failure(let err): print("An error occured \(err)")
                        }
                        group1.leave()
                    }
                }
                group1.notify(queue: .main) {
                    completion(.success(cuotasTan))
                }
            case .failure(let error):
                print("An error occured: \(error)")
                completion(.failure(error))
            }
        }
    }
}
