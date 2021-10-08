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
    
}
