//
//  ViewController.swift
//  ShoppingCart_Kaiser
//
//  Created by ANDREW KAISER on 10/31/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource{
  
    

    
    
    //outlets
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var addFieldOutlet: UITextField!
    
    var defaults = UserDefaults.standard
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        // Do any additional setup after loading the view.
        items.append("Chicken")
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        items.append(addFieldOutlet.text!)
        tableViewOutlet.reloadData()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(items) {
                            UserDefaults.standard.set(encoded, forKey: "theCart")
                        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }


}

