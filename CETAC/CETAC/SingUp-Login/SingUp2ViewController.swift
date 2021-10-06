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
        currAuth(){ (email) in
            dbIsAdmin(email: email){
                (res)in
                self.habilitarBoton(res: res)
            }
        }
    }
    
    func habilitarBoton(res: Bool){
        DispatchQueue.main.async {
            if(res != true){
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
    
    /*
     https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
     (?=.*[a-z])              -Ensure string has one character.
     (?=.[$@$#!%?&])   -Ensure string has one special character.
     {8,}                            -Ensure password length is 8.
     */
    func isPasswordValid(_ password : String) -> Bool{
          let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
          return passwordTest.evaluate(with: password)
      }
    
      //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func isValidEmail(_ email: String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: email)
      }
    
    //https://stackoverflow.com/questions/49992102/regular-expression-in-swift-to-validate-cardholder-name
    func isValidName(_ name: String) -> Bool {
          let emailRegEx = "(?<! )[A-Za-zÁÉÍÓÚáéíóúñÑ ]{2,26}"

          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: name)
      }
    
    func validateFields() -> String? {
            if nombreText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                apelllidoText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                correoText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                return "Llene todos los campos"
            }
            let cleanPass = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if !isPasswordValid(cleanPass){
                return "Ponga una contraseña segura, mínimo 8 caracteres, y 1 caracter especial"
            }
            let cleanCo = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if !isValidEmail(cleanCo){
                return "Ponga un email correcto"
            }
            
            let cleanName = nombreText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if !isValidName(cleanName){
                return "Ponga un nombre válido"
            }
            let cleanSurname = apelllidoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if !isValidName(cleanSurname){
                return "Ponga un apellido válido"
            }
            
            return nil
        }
    
    @IBAction func singUpTapped(_ sender: Any) {
        let error = validateFields()
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
