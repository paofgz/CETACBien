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
       
        var st = ""
        let h = "\(String(email))"
       
        db.collection(perfil).document(h).getDocument { (document, error ) in
            if error == nil{
                if document != nil && document!.exists {
                    let documentData = document!.data()
              
                    let n = documentData!["nombre"] as! String
                    //let a = documentData!["apellido"] as! String
                    
                    st = n.capitalizingFirstLetter2()
                    completion(st)
                }
            }
            
        }
       
    }
}
extension String {
    func capitalizingFirstLetter2() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter2() {
        self = self.capitalizingFirstLetter()
    }
}

