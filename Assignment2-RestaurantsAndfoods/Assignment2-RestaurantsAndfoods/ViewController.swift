//
//  ViewController.swift
//  Assignment2-RestaurantsAndfoods
//
//  Created by Xinyi Zhang on 2/13/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    let restaurants = ["Shake Shack","Jack's BBQ","Portage Bay Cafe","Mouchinut"]
    let foods = [["Shake Burger","Chick'N Shack","Somkeshack","Mushroom Burger"],["Brisket Plate","Pecan Pie","Potato Salad","Breakfast Tacos"],["Swedish Pancakes","Classic Benedict","French Toast","Organic House Salad"],["Doughnut","Boba Milk Tea","Rice Dog"]]
    var food = [String]();
    
    @IBOutlet weak var tblViewBottom: UITableView!
    @IBOutlet weak var tblViewTop: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewTop.delegate = self
        tblViewTop.dataSource = self
        tblViewBottom.delegate = self
        tblViewBottom.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewTop {
            return restaurants.count
        } else {
            return food.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewTop {
            let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            cell.textLabel?.text = restaurants[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            cell.textLabel?.text = food[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewTop {
            food = foods[indexPath.row]
            tblViewBottom.reloadData()
        }
        
        
        
    }
    
}
