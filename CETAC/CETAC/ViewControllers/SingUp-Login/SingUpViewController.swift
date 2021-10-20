//
//  SingUpViewController.swift
//  CETAC
//
//  Created by Yus Molina on 29/09/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SingUpViewController: UIViewController, UITextFieldDelegate {
    var singUpController = SingUpController()
    var validators = Validators()

    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var apellidoText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var experienciaText: UITextField!
    @IBOutlet weak var warningLabel: UILabel!

    @IBAction func ocultarTeclado(_ sender: UITapGestureRecognizer) {
        nombreText.resignFirstResponder()
        apellidoText.resignFirstResponder()
        correoText.resignFirstResponder()
        passwordText.resignFirstResponder()
        experienciaText.resignFirstResponder()
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
                self.signUpButton.isEnabled = false
                self.signUpButton.backgroundColor = UIColor(red: 150/255, green: 152/255, blue: 154/255, alpha: 0.5)
                self.warningLabel.alpha = 1
            }
        }
    }
    
    func setUpElemets(){
        passwordText.delegate = self
        nombreText.delegate = self
        apellidoText.delegate = self
        correoText.delegate = self
    }
    
  
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validators.validateFields(nombreText:nombreText.text!, apellidoText:apellidoText.text!, correoText:correoText.text!, passwordText:passwordText.text!, experienciaText:experienciaText.text!)

        if error != nil {
            showError(error!)
        }else {
            let nombreClean = nombreText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellidoClean = apellidoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let correoClean = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordClean = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let experienciaClean = experienciaText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: correoClean, password: passwordClean) { result, err in
                if err != nil {
                    self.showError("fail")
                }else{
                    let db = Firestore.firestore()
                   
                    db.collection("Tanatologo").document(correoClean).setData(["apellido": apellidoClean, "correo": correoClean, "nombre": nombreClean, "uid":result!.user.uid , "experiencia": experienciaClean]) { (error) in
                        if let error = error {
                            self.showError("Fail ")
                        }
                        
                    }
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)

    }
   
    func transitionToHome(){
        let alert = UIAlertController(title: "Tanatólogo registrado exitosamente", message: ":D", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
        nombreText.text = nil
        apellidoText.text = nil
        correoText.text = nil
        passwordText.text = nil
        experienciaText.text = nil
        showError("")
        
    }
}
