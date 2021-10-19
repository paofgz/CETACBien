//
//  Validators.swift
//  CETAC
//
//  Created by Yus Molina on 07/10/21.
//

import Foundation
import Firebase
import FirebaseAuth

class Validators{
    /*
     https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
     (?=.*[a-z])              -Ensure string has one character.
     (?=.[$@$#!%?&])   -Ensure string has one special character.
     (?=.*[0-9])      -One number
     {8,}                            -Ensure password length is 8.
     */

    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])[A-Za-z\\d$@$#!%*?&]{8,}")
       
        return passwordTest.evaluate(with: password)
    }
    //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
   

    //https://stackoverflow.com/questions/49992102/regular-expression-in-swift-to-validate-cardholder-name
    //https://es.stackoverflow.com/questions/199139/expresi%C3%B3n-regular-para-validar-s%C3%B3lo-letras-y-espacios-acentos-la-que-me-funcion
    func isValidName(_ name: String) -> Bool {
        let emailRegEx = "(?<! )[A-Za-zÁÉÍÓÚáéíóúñÑ ]{2,26}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: name)
    }
    
    //https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number
    func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneRegEx = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: number)
    }
    
    //https://stackoverflow.com/questions/54208204/regular-expressions-age-validation-17-120
    func isValidAge(_ age: String) -> Bool {
        let ageRegEx = #"100|[1-9]?\d"#
        let agePred = NSPredicate(format:"SELF MATCHES %@", ageRegEx)
        return agePred.evaluate(with: age)
    }
    
    func isValidSex(_ sex:String) -> Bool {
        if (sex != "Hombre" && sex != "Mujer" && sex != "No binario" && sex != "Prefiero no decir"){
            return false
        }
        return true
    }
    
    //https://stackoverflow.com/questions/54800691/how-to-create-regex-for-int-and-float-value-using-swift-4-2
    func isValidCuota(_ cuota:String) -> Bool {
        let cuotaRegEx = "^[0-9]+(?:[.,][0-9]+)*$"
        let cuotaPred = NSPredicate(format:"SELF MATCHES %@", cuotaRegEx)
        return cuotaPred.evaluate(with: cuota)
    }
    
    func isValidChildren(_ child:String) -> Bool {
        let childRegEx = "[A-Za-zÁÉÍÓÚáéíóúñÑ]+[MH]+(100|[1-9])"
        let childPred = NSPredicate(format:"SELF MATCHES %@", childRegEx)
        return childPred.evaluate(with: child)
    }
    
    func validateFields(correoText : String!, passwordText : String!) -> String? {
        
        if correoText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Llene todos los campos"
        }
        let cleanPass = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isPasswordValid(cleanPass){
            return "Ponga una contraseña segura, mínimo 8 caracteres, y 1 caracter especial"
        }
        let cleanCo = correoText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(cleanCo){
            return "Ponga un email correcto"
        }
        
        return nil
    }
    func validateFields(nombreText:String! , apellidoText:String!, correoText:String!,passwordText:String!, experienciaText:String!) -> String? {
        if nombreText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            apellidoText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            correoText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            experienciaText.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Llene todos los campos"
        }
        let ret = validateFields(nombreText: nombreText, apellidoText: apellidoText, correoText: correoText, passwordText:passwordText)
        return ret

    }
    
    
    func validateFields(nombreText:String! , apellidoText:String!, correoText:String!,passwordText:String!) -> String? {
        
        if nombreText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            apellidoText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            correoText.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Llene todos los campos"
        }
        let ret = validateFields(correoText: correoText, passwordText: passwordText)
        
        /*let cleanPass = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isPasswordValid(cleanPass){
            return "Ponga una contraseña segura, mínimo 8 caracteres, y 1 caracter especial"
        }
        let cleanCo = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(cleanCo){
            return "Ponga un email correcto"
        }
        */
        let cleanName = nombreText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidName(cleanName){
            return "Ponga un nombre válido"
        }
        let cleanSurname = apellidoText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidName(cleanSurname){
            return "Ponga un apellido válido"
        }
        
        return ret
    }
    
    func validateEncuadre(nombre:String, celular:String, telefono:String, edadPareja:String, sexoPareja:String, referido:String, cuotaRec:String, edad:String, hijos:String) -> String? {
        if !isValidName(nombre){
            return "Ponga un nombre válido"
        }
        if !isValidName(referido){
            return "Ponga un nombre de referido válido"
        }
        if !isValidPhoneNumber(celular){
            return "El número de teléfono y el celular debe contener 10 números"
        }
        if !isValidPhoneNumber(telefono){
            return "El número de teléfono y el celular debe contener 10 números"
        }
        if edadPareja != "" {
            if !isValidAge(edadPareja){
                return "La edad de pareja ingresada no es válida"
            }
        }
        if !isValidAge(edad){
            return "La edad ingresada no es válida"
        }
        if !isValidSex(sexoPareja){
            return "El sexo ingresado no es válido"
        }
        if cuotaRec != "" {
            if !isValidCuota(cuotaRec){
                return "La cuota de recuperación ingresada no es válida"
            }
        }
        /*if hijos != "" {
            if !isValidChildren(hijos){
                return "Los hijos se deben ingresar como nombre, sexo (H/M), edad y ';' ej: SantiagoH12;MariaM9"
            }
        }*/
        return nil
    }
    
}
