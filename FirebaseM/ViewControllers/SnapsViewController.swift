//
//  SnapsViewController.swift
//  FirebaseM
//
//  Created by mbtec22 on 5/27/21.
//

import UIKit

class SnapsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
