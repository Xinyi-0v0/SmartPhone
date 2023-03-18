//
//  ViewController.swift
//  SevenWonders
//
//  Created by Xinyi Zhang on 3/18/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    let imageNames = ["China", "Italy", "Jordan", "Mexico","Brazil", "India", "Peru"]
    let titles = ["The Great Wall, China","The Colosseum, Italy","Petra, Jordan","Mexico, Chichén Itzá, Mexico","Christ the Redeemer, Brazil","Taj Mahal, India", "Machu Picchu, Peru"]
    
    var selectedIndex = 0
    @IBOutlet weak var tblView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
                        
                cell.imgContainer.image = UIImage(named: imageNames[indexPath.row])
                cell.lblImage.text = titles[indexPath.row]
                return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any? ){
        if segue.identifier == "segueDetails" {
            let secondVC = segue.destination as! DetailsViewController
            secondVC.wonderIndex = selectedIndex
        }
    }
    
}

