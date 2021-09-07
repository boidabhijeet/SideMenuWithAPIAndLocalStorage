//
//  MenuBarViewController.swift
//  DefineLabs
//
//  Created by Abhi on 06/09/21.
//

import UIKit
import SideMenu

class MenuBarViewController: UIViewController {

    @IBOutlet weak var menuBarTableView: UITableView!
    let menuItems = ["Venues", "Saved Venues"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension MenuBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell")
        cell?.textLabel?.text = menuItems[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if menuItems[indexPath.row] == "Venues" {
            let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: "SavedViewController") as! SavedViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

