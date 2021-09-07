//
//  SavedViewController.swift
//  DefineLabs
//
//  Created by Abhi on 06/09/21.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var savedTableView: UITableView!
//    private var models = [Venues]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedItems : [Venues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllItems()
    }
    
    func getAllItems(){
        do{
            savedItems = try context.fetch(Venues.fetchRequest())
            DispatchQueue.main.async {
                self.savedTableView.reloadData()
            }
        }catch{
            //error
        }
    }
    
    func deleteItem(item : Venues){
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }
}

extension SavedViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell")
        cell?.textLabel?.text = savedItems[indexPath.row].name
        cell?.detailTextLabel?.text =
            "\(savedItems[indexPath.row].city ?? ""), \(savedItems[indexPath.row].state ?? ""), \(savedItems[indexPath.row].country ?? "")"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = savedItems[indexPath.row]
        deleteItem(item: item)
    }
}
