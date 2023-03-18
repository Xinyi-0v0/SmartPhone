//
//  ViewController.swift
//  MakeAPICall
//
//  Created by Xinyi Zhang on 3/18/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner



class ViewController: UIViewController {

    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtSymbol: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getInfo(_ sender: Any) {
        getStockDataFromAPI()
    }
    
    func getStockDataFromAPI(){
        guard let symbol = txtSymbol.text else {return}
        let url = "\(baseURL)\(symbol)?apikey=\(apiKey)"
        
        SwiftSpinner.show("Getting Stock price for \(symbol)")
        AF.request(url).responseData { response in
            SwiftSpinner.hide()
            if response.error != nil {
                print("Error in res")
                return
            }
            
            // At this point I go a valid response
            guard let rawData = response.data else {return}
            guard let jsonArray = JSON(rawData).array else {return}
            guard let stock = jsonArray.first else {return}
    
            
            let name = stock["companyName"].stringValue
            let price = stock["price"].floatValue
            let website = stock["website"].stringValue
            
            print(name)
            print(price)
            print(website)
            
            self.lblName.text="Company Name: \(name)"
            self.lblPrice.text="Price: \(price)"
            self.lblWebsite.text="Website: \(website)"

            
        }
    }
        
}


