//
//  SnapsViewController.swift
//  FirebaseM
//
//  Created by mbtec22 on 5/27/21.
//

import UIKit
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var snaps: [Snap] = []
    private let database = Database.database().reference()
    var usuarios : [Usuario] = []
    var imageFire = ""
    var descripcionn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
