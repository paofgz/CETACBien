//
//  SingUpController.swift
//  CETAC
//
//  Created by Yus Molina on 05/10/21.
//

import Foundation
import Firebase
import FirebaseAuth

class SingUpController{
    var validators = Validators()
    func currAuth( completion: @escaping (String) -> Void){
        let user = Auth.auth().currentUser
        
        if let user = user {
            let email = user.email
            completion(email!)
        }
    }


    func dbIsAdmin(email:String, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
       
        db.collection("Administradores").document(email).getDocument { (document, error ) in
            if error == nil{
                if document != nil && document!.exists {
                    let documentData = document!.data()
                    let res = documentData!["esSoporte"] as! Bool
                    completion(res)
                   
                }
            }
            
        }
       
    }
    

   
}
