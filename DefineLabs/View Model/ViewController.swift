//
//  ViewController.swift
//  DefineLabs
//
//  Created by Abhi on 04/09/21.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
    
    var dataModel : [Venue]?
    var menu: SideMenuNavigationController?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func menuTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        //Swipe Gesture to open/close SideMenu
        SideMenuManager.defaultManager.leftMenuNavigationController = menu
        SideMenuManager.defaultManager.addPanGestureToPresent(toView: self.view)
        getAPIData()
    }
    
    func getAPIData(){
        let url = String(format: "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616")
        
        guard let serviceUrl = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data,_,error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(DataModel.self, from: data)
                    self.dataModel = decodedResponse.response?.venues
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func createItem(name: String, city: String, state: String, country: String){
        let newItem = Venues(context: context)
        newItem.name = name
        newItem.city = city
        newItem.state = state
        newItem.country = country
        do{
            try context.save()
        }catch{
            //error
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VenueTableViewCell
        cell.title?.text = dataModel?[indexPath.row].name
        cell.subTitle?.text = "\(dataModel?[indexPath.row].location?.city ?? ""), \(dataModel?[indexPath.row].location?.state ?? ""), \(dataModel?[indexPath.row].location?.country ?? "")"
        cell.venueSelected.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataModel?[indexPath.row]
        createItem(name: (item?.name)!, city: (item?.location?.city)!, state: (item?.location?.state)!, country: (item?.location?.country)!)
        let cell = self.tableView.cellForRow(at: indexPath) as! VenueTableViewCell
        if cell.venueSelected.tintColor == #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2666666667, alpha: 1) {
            cell.venueSelected.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            cell.venueSelected.tintColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0.2666666667, alpha: 1)
        }
        // Golden Color: FFD544
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}

class MenuListController: UITableViewController {
    let menuItems = ["Venues", "Saved Venues"]
    let darkColor = UIColor(red: 33/250.0, green: 33/250.0, blue: 33/250.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .yellow
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell")
        cell?.textLabel?.text = menuItems[indexPath.row]
        cell?.textLabel?.font = UIFont(name:"Optima Bold Italic", size: 18)
        cell?.backgroundColor = .yellow
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if menuItems[indexPath.row] == "Venues" {
            let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard.instantiateViewController(identifier: "SavedViewController") as! SavedViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
