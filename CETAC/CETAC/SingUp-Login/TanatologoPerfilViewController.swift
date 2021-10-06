//
//  TanatologoPerfilViewController.swift
//  CETAC
//
//  Created by Yus Molina on 03/10/21.
//

import UIKit
import FirebaseAuth
import Firebase

class TanatologoPerfilViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var correoLabel: UILabel!
    
    @IBAction func logOutPress(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        
       } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
       }
            view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authActual(){ (email) in
            fetchTanatologo(email: email){
                (st)in
                self.cargar(st: st)
                self.correoLabel.text = email
            }
        }
    }
    
    func cargar(st: String){
        DispatchQueue.main.async {
        self.nameLabel.text = st
        }
    }
  
}
