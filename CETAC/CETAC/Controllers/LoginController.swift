//
//  LoginController.swift
//  CETAC
//
//  Created by Yus Molina on 03/10/21.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginController{
    var validators = Validators()
    func logIn(passwordClean:String, emailClean:String, completion: @escaping (Result<String, Error>) -> Void){
        
        Auth.auth().signIn(withEmail: emailClean, password: passwordClean) { (result, error) in
            if error != nil {
                completion(.failure(error!))
            }else{
                let user = Auth.auth().currentUser
                if let user = user {
                    let email = user.email
                    completion(.success(email!))
                }
            }
        }
    }

    func isAdministrator(email:String, completion: @escaping (String) -> Void){
        var tmp = ""
        let db = Firestore.firestore()
        
        db.collection("Administradores").document(String(email)).getDocument { (document, error ) in
            if error == nil {
                if document != nil && document!.exists {
                    tmp = "inicialAdmin"
                    completion(tmp)
                }
            }else {
                tmp = "tanatologoInicial"
                completion(tmp)
            }
            tmp = "tanatologoInicial"
            completion(tmp)
        }
    }

   
    
}
