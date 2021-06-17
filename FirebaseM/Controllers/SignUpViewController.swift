//
//  SignUpViewController.swift
//  FirebaseM
//
//  Created by mbtec22 on 5/27/21.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


class SignUpViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    private let database = Database.database().reference()
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()

        // Do any additional setup after loading the view.
    }
    
    func setUpStyle(){
        signUpButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let user = userTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (responseUser, error) in
            if error == nil {
                
                let usermodel = User(username: "\(user)", user: "\(email)")
                let authuser = Auth.auth().currentUser
                
                let object : [String: Any] = [
                    "email": "\(email)" as NSObject,
                    "user" : "\(user)" as NSObject
                ]
                print(object)
               // self.storeUser(user: object, uid: Auth.auth().currentUser!.uid)
                
                Database.database().reference().child("users").child(authuser!.uid).setValue(object)
                //self.db.collection("users").document(Auth.auth().currentUser!.uid).setData([
                //    "email":email,
                //    "user": user
                //])
                print("El usuario fue creado exitosamente")
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecto", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func storeUser(user: [String: Any], uid: String) {
        if let databaseReference = try? database.child("users").child(uid){
            databaseReference.setValue(user) { error, ref in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("Else")
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
}
