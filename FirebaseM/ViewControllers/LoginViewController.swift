//
//  LoginViewController.swift
//  FirebaseM
//
//  Created by mbtec22 on 5/13/21.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userOrEmailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        userOrEmailTextField.text="alvaro.motta@gmail.com"
        passwordField.text="amotta"
    }
    
    func setUpStyle(){
        loginButton.layer.cornerRadius = 6.0
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let user = userOrEmailTextField.text!
        let password = passwordField.text!
        Auth.auth().signIn(withEmail: user, password: password) { (responseUser, error) in
            print("Intentamos iniciar sesión")
            if error == nil {
                print("Se inició sesión")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else {
                let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecto", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                print("Salió mal")
        }
        
    }

}
}
