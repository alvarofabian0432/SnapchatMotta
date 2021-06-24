//
//  ImagenViewController.swift
//  FirebaseM
//
//  Created by mbtec22 on 5/27/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let url = info[UIImagePickerController.InfoKey.imageURL] as! URL
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        let imagenData = imageView.image!.pngData()!
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        
        
        imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData, metadata: nil, completion:{(metadata, error) in
            imagenesFolder.downloadURL {url, error in
                guard let url = url else {return}
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: url.absoluteString)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ElegirUsuarioViewController
        nextVC.imageFire = sender as! String
        nextVC.descripcionn = descripcionTextField.text!
        
    }

}
