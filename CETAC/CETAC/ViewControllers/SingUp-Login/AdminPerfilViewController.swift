//
//  AdminPerfilViewController.swift
//  CETAC
//
//  Created by Yus Molina on 03/10/21.
//

import UIKit
import Firebase
import FirebaseAuth

class AdminPerfilViewController: UIViewController {
    var perfilController = PerfilController()

    @IBOutlet weak var correoLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBAction func pressed(_ sender: Any){
        
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

        perfilController.authActua(){ (email) in
            self.perfilController.fetchPerfil(email: email, perfil: "Administradores"){
                (st)in
                self.cargar(st: st)
                self.correoLabel.text = email
            }
        }
    }
    
    func cargar(st: String){
        DispatchQueue.main.async {
        self.nombreLabel.text = st
        }
    }

}
