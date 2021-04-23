//
//  FCBFoodDetailsViewController.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit

class FCBFoodDetailsViewController: UITableViewController {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodFavoriteButton: UIButton!
    @IBOutlet weak var foodNameLabel: UIView!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var FoodIncredientsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food Details"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func foodFavoriteButtonAction(_ sender: Any) {
        
    }
    
}
