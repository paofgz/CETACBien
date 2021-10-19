//
//  TanatologoChartController.swift
//  CETAC
//
//  Created by Yus Molina on 15/10/21.
//

import Foundation
import Firebase
import FirebaseAuth
class TanatologoChartController{
 
    func fetchPerfil(email:String, perfil:String, completion: @escaping (String) -> Void){
        let db = Firestore.firestore()
        let h = "\(String(email))"
       
        db.collection(perfil).document(h).getDocument { (document, error ) in
            if error == nil{
                if document != nil && document!.exists {
                    let documentData = document!.data()
                    let n = documentData!["nombre"] as! String
                    completion(n.capitalizingFirstLetter())
                }
            }
        }
    }
}

