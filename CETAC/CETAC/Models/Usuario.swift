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
    
    let id, EKR, celular, domicilio, estadoCivil, idTanatologo, identificacionDeRespuesta, motivo, nombre, ocupacion, procedencia, referido, religion, sexoPareja, telefonoDeCasa, proximaSesion, sexo, hijos: String
    let edadPareja, status, edad, numSes: Int
    let fecha, lastSes: Date
    init(id:String, fecha:Date, idTanatologo:String, nombre:String, ocupacion:String, religion: String, procedencia:String, domicilio:String, telefonoDeCasa:String, celular:String, estadoCivil:String, edadPareja:Int, sexoPareja:String, hijos:String, referido:String, motivo:String, identificacionDeRespuesta:String, EKR:String, status:Int, proximaSesion:String, sexo:String, edad:Int, numSes:Int, lastSes:Date){
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
        self.hijos = hijos
        self.referido = referido
        self.motivo = motivo
        self.identificacionDeRespuesta = identificacionDeRespuesta
        self.EKR = EKR
        self.proximaSesion = proximaSesion
        self.status = status
        self.sexo = sexo
        self.edad = edad
        self.numSes = numSes
        self.lastSes = lastSes
    }

    init(fecha:Date, idTanatologo:String, nombre:String, ocupacion:String, religion: String, procedencia:String, domicilio:String, telefonoDeCasa:String, celular:String, estadoCivil:String, edadPareja:Int, sexoPareja:String, hijos:String, referido:String, motivo:String, identificacionDeRespuesta:String, EKR:String, status:Int, proximaSesion:String, sexo:String, edad:Int, numSes:Int, lastSes:Date){
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
        self.hijos = hijos
        self.referido = referido
        self.motivo = motivo
        self.identificacionDeRespuesta = identificacionDeRespuesta
        self.EKR = EKR
        self.proximaSesion = proximaSesion
        self.status = status
        self.sexo = sexo
        self.edad = edad
        self.numSes = numSes
        self.lastSes = lastSes
    }

    init(aDoc: DocumentSnapshot){
        let now = Date()
        self.id = aDoc.documentID
        self.fecha = (aDoc.get("fecha") as? Timestamp)?.dateValue() ?? now
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
        self.hijos = aDoc.get("hijos") as? String ?? ""
        self.referido = aDoc.get("referido") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.identificacionDeRespuesta = aDoc.get("identificacionDeRespuesta") as? String ?? ""
        self.EKR = aDoc.get("EKR") as? String ?? ""
        self.proximaSesion = aDoc.get("proximaSesion") as? String ?? ""
        self.status = aDoc.get("status") as? Int ?? 0
        self.sexo = aDoc.get("sexo") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? 0
        self.numSes = aDoc.get("numSes") as? Int ?? 0
        self.lastSes = (aDoc.get("lastSes") as? Timestamp)?.dateValue() ?? now
    }
}

typealias Usuarios = [Usuario]

