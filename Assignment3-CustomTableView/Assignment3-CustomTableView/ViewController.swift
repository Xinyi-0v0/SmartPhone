//
//  ViewController.swift
//  Assignment3-CustomTableView
//
//  Created by Xinyi Zhang on 2/18/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let imageNames = ["Farfalle", "Hamburger", "Steak", "Sandwich", "Salad","Fruits"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
                        
                cell.imgContainer.image = UIImage(named: imageNames[indexPath.row])
                cell.lblImage.text = imageNames[indexPath.row]
                
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

