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
    var cart = [String]()
    //alert controllers
    var alert: UIAlertController!
    var okAction: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        // Do any additional setup after loading the view.
        cart.append("Chicken")
        
        //alerts
        alert = UIAlertController(title: "Overlapping Items", message: "Item is already in cart", preferredStyle: .alert)
        okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        //
        if let items = defaults.data(forKey: "theCart") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([String].self, from: items) {
                            cart = decoded
                        }
                }
        tableViewOutlet.reloadData()
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        for x in cart{
            if x == addFieldOutlet.text {
                present(alert, animated: true)
                addFieldOutlet.text = ""
                return
            }
        }
        cart.append(addFieldOutlet.text!)
        tableViewOutlet.reloadData()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(cart) {
                            defaults.set(encoded, forKey: "theCart")
                        }
    }
    
    @IBAction func sortAction(_ sender: Any) {
        cart.sort(by: <)
        tableViewOutlet.reloadData()
    }
    
    
    
    
    // num of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    // pops each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(cart[indexPath.row])"
        return cell
    }
    //cell they selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if(cell?.accessoryType == .checkmark){
            cell?.accessoryType = .none
        } else {
            cell!.accessoryType = .checkmark
        }
        tableView.reloadData()
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        cell!.accessoryType = .none
//        tableView.reloadData()
//    }
    
    //deleting if user swipes left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cart.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
            tableViewOutlet.reloadData()
        }
    }


}

