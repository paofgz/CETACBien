//
//  LoginViewController.swift
//  CETAC
//
//  Created by Yus Molina on 29/09/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var correoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func dismissTeclado(_ sender: UITapGestureRecognizer) {
        correoText.resignFirstResponder()
        passwordText.resignFirstResponder()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElemets()
    }
    
    func setUpElemets (){
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
    func validateFields() -> String? {
        if correoText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
        
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else {
            let emailClean = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordClean = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            logIn( passwordClean: passwordClean, emailClean: emailClean){ (result) in
                switch result{
                    case .success(let email): isAdministrator(email: email){
                        (tmp)in
                        self.actualizaUi(tmp: tmp)
                    }
                case .failure(_):self.showError("El usuario y la contraseña no coinciden")
                }

            }
        }
       
    }
    
    func actualizaUi(tmp: String){
        DispatchQueue.main.async {
            self.passwordText.text = nil
            self.correoText.text = nil
 
            //https://fluffy.es/how-to-transition-from-login-screen-to-tab-bar-controller/
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            print(tmp)
            let mainTabBarController = storyboard.instantiateViewController(identifier: tmp)
            mainTabBarController.modalPresentationStyle = .fullScreen
                
            self.present(mainTabBarController, animated: true, completion: nil)

        }
    }
   
    func showError(_ message:String){
        self.passwordText.text = nil
        self.correoText.text = nil
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
