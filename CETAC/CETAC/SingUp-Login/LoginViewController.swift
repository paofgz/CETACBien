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
    var loginController = LoginController()
    var validators = Validators()

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
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validators.validateFields(correoText:correoText.text!, passwordText: passwordText.text!)
        if error != nil {
            showError(error!)
        }else {
            let emailClean = correoText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordClean = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            loginController.logIn( passwordClean: passwordClean, emailClean: emailClean){ (result) in
                switch result{
                    case .success(let email): self.loginController.isAdministrator(email: email){
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
