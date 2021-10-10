//
//  SingUp2ViewController.swift
//  CETAC
//
//  Created by Yus Molina on 02/10/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SingUp2ViewController: UIViewController, UITextFieldDelegate {
    var validators = Validators()
    var singUpController = SingUpController()
    
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var apelllidoText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var soporteSwitch: UISwitch!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBAction func dismissTeclado(_ sender: UITapGestureRecognizer) {
        nombreText.resignFirstResponder()
        apelllidoText.resignFirstResponder()
        correoText.resignFirstResponder()
        passwordText.resignFirstResponder()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElemets()
        singUpController.currAuth(){ (email) in
            self.singUpController.dbIsAdmin(email: email){
                (res)in
                self.habilitarBoton(res: res)
            }
        }
    }
    
    func habilitarBoton(res: Bool){
        DispatchQueue.main.async {
            if(res == true){
                self.singUpButton.isEnabled = false
                self.singUpButton.backgroundColor = UIColor(red: 150/255, green: 152/255, blue: 154/255, alpha: 0.5)
                self.alertLabel.alpha = 1
            }
        }
    }

    func setUpElemets(){
        nombreText.delegate = self
        apelllidoText.delegate = self
        correoText.delegate = self
        passwordText.delegate = self
      }
    
    
    @IBAction func singUpTapped(_ sender: Any) {
        let error = validators.validateFields(nombreText:nombreText.text!, apellidoText:apelllidoText.text!,correoText:correoText.text!,passwordText:passwordText.text!)
        if error != nil {
            showError(error!)
        }else {
            let nombreClean = nombreText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellidoClean = apelllidoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let correoClean = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordClean = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let switchCase = soporteSwitch.isOn
                    
            Auth.auth().createUser(withEmail: correoClean, password: passwordClean) { result, err in
                if err != nil {
                    self.showError("fail")
                }else{
                    let db = Firestore.firestore()
                    db.collection("Administradores").document(correoClean).setData(["apellido": apellidoClean, "correo": correoClean, "nombre": nombreClean, "uid":result!.user.uid, "esSoporte": switchCase]) { (error) in
                        if let error = error {
                            self.showError("fail 2 :(")
                        }
                                
                    }
                    self.transitionToHome()
                }
            }
        }
               
    }
    
    func showError(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
      }

    func transitionToHome(){
        let alert = UIAlertController(title: "Admin registrado exitosamente", message: "YAY :D", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Super", style: .default, handler: nil))
            
        self.present(alert, animated: true)
        nombreText.text = nil
        apelllidoText.text = nil
        correoText.text = nil
        passwordText.text = nil
        showError("")
        
    }
}
