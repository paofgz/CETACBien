//
//  Usuario.swift
//  CETAC
//
//  Created by Paola Fernández on 28/09/21.
//

import Foundation
import Firebase
var sesionControlador = SesionesController()

struct Usuario: Codable {
    
    let id, EKR, celular, domicilio, edadesHijos, estadoCivil, idTanatologo, identificacionDeRespuesta, motivo, nombre, ocupacion, procedencia, referido, religion, sexoHijos, sexoPareja, telefonoDeCasa, fecha, proximaSesion: String
    let numeroDeHijos, edadPareja, status: Int
    init(id:String, fecha:String, idTanatologo:String, nombre:String, ocupacion:String, religion: String, procedencia:String, domicilio:String, telefonoDeCasa:String, celular:String, estadoCivil:String, edadPareja:Int, sexoPareja:String, numeroDeHijos:Int, edadesHijos:String, sexoHijos:String, referido:String, motivo:String, identificacionDeRespuesta:String, EKR:String, status:Int, proximaSesion:String){
            self.id = id
            self.fecha = fecha
            self.idTanatologo = idTanatologo
            self.nombre = nombre
            self.ocupacion = ocupacion
            self.religion = religion
            self.procedencia = procedencia
            self.domicilio = domicilio
            self.telefonoDeCasa = telefonoDeCasa
            self.celular = celular
            self.estadoCivil = estadoCivil
            self.edadPareja = edadPareja
            self.sexoPareja = sexoPareja
            self.numeroDeHijos = numeroDeHijos
            self.edadesHijos = edadesHijos
            self.sexoHijos = sexoHijos
            self.referido = referido
            self.motivo = motivo
            self.identificacionDeRespuesta = identificacionDeRespuesta
            self.EKR = EKR
            self.proximaSesion = proximaSesion
            self.status = status
    }

    init(fecha:String, idTanatologo:String, nombre:String, ocupacion:String, religion: String, procedencia:String, domicilio:String, telefonoDeCasa:String, celular:String, estadoCivil:String, edadPareja:Int, sexoPareja:String, numeroDeHijos:Int, edadesHijos:String, sexoHijos:String, referido:String, motivo:String, identificacionDeRespuesta:String, EKR:String, status:Int, proximaSesion:String){
            self.id = ""
            self.fecha = fecha
            self.idTanatologo = idTanatologo
            self.nombre = nombre
            self.ocupacion = ocupacion
            self.religion = religion
            self.procedencia = procedencia
            self.domicilio = domicilio
            self.telefonoDeCasa = telefonoDeCasa
            self.celular = celular
            self.estadoCivil = estadoCivil
            self.edadPareja = edadPareja
            self.sexoPareja = sexoPareja
            self.numeroDeHijos = numeroDeHijos
            self.edadesHijos = edadesHijos
            self.sexoHijos = sexoHijos
            self.referido = referido
            self.motivo = motivo
            self.identificacionDeRespuesta = identificacionDeRespuesta
            self.EKR = EKR
            self.proximaSesion = proximaSesion
            self.status = status
    }

    init(aDoc: DocumentSnapshot){
        self.id = aDoc.documentID
        self.fecha = aDoc.get("fecha") as? String ?? ""
        self.idTanatologo = aDoc.get("idTanatologo") as? String ?? ""
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.ocupacion = aDoc.get("ocupacion") as? String ?? ""
        self.religion = aDoc.get("religion") as? String ?? ""
        self.procedencia = aDoc.get("procedencia") as? String ?? ""
        self.domicilio = aDoc.get("domicilio") as? String ?? ""
        self.telefonoDeCasa = aDoc.get("telefonoDeCasa") as? String ?? ""
        self.celular = aDoc.get("celular") as? String ?? ""
        self.estadoCivil = aDoc.get("estadoCivil") as? String ?? ""
        self.edadPareja = aDoc.get("edadPareja") as? Int ?? 0
        self.sexoPareja = aDoc.get("sexoPareja") as? String ?? ""
        self.numeroDeHijos = aDoc.get("numeroDeHijos") as? Int ?? 0
        self.edadesHijos = aDoc.get("edadesHijos") as? String ?? ""
        self.sexoHijos = aDoc.get("sexoHijos") as? String ?? ""
        self.referido = aDoc.get("referido") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.identificacionDeRespuesta = aDoc.get("identificacionDeRespuesta") as? String ?? ""
        self.EKR = aDoc.get("EKR") as? String ?? ""
        self.proximaSesion = aDoc.get("proximaSesion") as? String ?? ""
        self.status = aDoc.get("status") as? Int ?? 0
    }
}

typealias Usuarios = [Usuario]
