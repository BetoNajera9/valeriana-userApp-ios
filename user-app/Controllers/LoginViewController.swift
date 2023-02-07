//
//  LoginViewController.swift
//  user-app
//
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    let user = (email: "correo@hotmail.com", password: "password")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateLogin() -> String? {
        let email = tfEmail.text!
        let password = tfPassword.text!
        
        if email != user.email  { return "Correo electrónico invalido" }
        if password != user.password  { return "Contraseña invalida" }

        return nil
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            if let error = validateLogin() {
                self.view.makeToast(error)
                return false
            }
        }
        
        return true
    }
}
