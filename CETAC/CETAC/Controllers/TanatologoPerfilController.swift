//
//  TanatologoPerfilController.swift
//  CETAC
//
//  Created by Yus Molina on 03/10/21.
//

import Foundation
import Firebase
import FirebaseAuth

func authActual( completion: @escaping (String) -> Void){
    let user = Auth.auth().currentUser
    
    if let user = user {
        let email = user.email
        completion(email!)
    }
}

func fetchTanatologo(email:String, completion: @escaping (String) -> Void){
    let db = Firestore.firestore()
   
    var st = ""
    let h = "\(String(email))"
   
    db.collection("Tanatologo").document(h).getDocument { (document, error ) in
        if error == nil{
            if document != nil && document!.exists {
                let documentData = document!.data()
          
                let n = documentData!["nombre"] as! String
                let a = documentData!["apellido"] as! String
                
                st = n.capitalizingFirstLetter1()+" "+a.capitalizingFirstLetter1()
                completion(st)
               
            }
        }
        
    }
   
}
extension String {
    func capitalizingFirstLetter1() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter1() {
        self = self.capitalizingFirstLetter()
    }
}
