//
//  servicioController.swift
//  CETAC
//
//  Created by Annya Verduzco on 16/10/21.
//

import Foundation
import Firebase

class servicioController{
    let db = Firestore.firestore()
    var usuarioControlador = UsuarioController()
    var sesionControlador = SesionesController()
    var motivoController = MotivoController()
    
    func fetchSesiones(fechaInicio: Date, fechaFin: Date, completion: @escaping (Result<[Sesion], Error>) -> Void) {
        var sesiones:[Sesion] = []
        let group = DispatchGroup()
        
        self.motivoController.fetchUsuarios(fechaInicio: fechaInicio, fechaFinal: fechaFin){(result) in
            switch result {
            case .success(let usuarios):
                for usuario in usuarios {
                    group.enter()
                    self.sesionControlador.fetchSesiones(usuario.id) { (res) in
                        switch res {
                        case .success(let S):
                            for sesion in S {
                                sesiones.append(sesion)
                            }
                        case.failure(let err): print("No se pudo acceder a las sesiones: \(err)")
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main){
                    completion(.success(sesiones))
                }
            case .failure(let error):
                print("No se pudo acceder a los usuarios: \(error)")
                completion(.failure(error))
            }
            
        }
    }
    
    
}


