//
//  FCBFoodDetailsViewController.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit
import KSToastView
import SVProgressHUD

class FCBFoodDetailsViewController: UITableViewController {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodFavoriteButton: UIButton!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var FoodIncredientsLabel: UILabel!
    
    var identifer = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Food Details"
        getProductDetails(identifier: identifer)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func foodFavoriteButtonAction(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260.0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260.0
        }
        return UITableView.automaticDimension
    }
}

// MARK: API

extension FCBFoodDetailsViewController {
    fileprivate func getProductDetails(identifier: String) {
        SVProgressHUD.show()
        FCBMealDetailsService().request(identifier: identifier) { [weak self] (status, result) in
            guard let _ = self else { return }
            guard let response = result as? FCBSearchModel else {
                KSToastView.ks_showToast(FCBStrings.errorServer)
                SVProgressHUD.dismiss()
                return
            }
            if response.meals.count > 0 {
                self?.setUI(info: response.meals.first)
                SVProgressHUD.dismiss()
            } else {
                KSToastView.ks_showToast(FCBStrings.errorData)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func setUI(info: FCBMeals?) {
        guard let mealInfo = info else {
            KSToastView.ks_showToast(FCBStrings.errorData)
            return
        }
        self.foodImage.loadImage(with: mealInfo.strMealThumb ?? "")
        self.foodNameLabel.text = mealInfo.strMeal
        self.foodDescriptionLabel.text = mealInfo.strInstructions
        self.FoodIncredientsLabel.text = prepareIncredents(info: mealInfo)
        self.tableView.reloadData()
    }
    
    private func prepareIncredents(info: FCBMeals) -> String {
        var mealIncredents = ""
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient1))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient2))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient3))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient4))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient5))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient6))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient7))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient8))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient9))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient10))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient11))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient12))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient13))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient14))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient15))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient16))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient17))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient18))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient19))
        mealIncredents.append(appendWithNewLineCharacter(value: info.strIngredient20))
        return mealIncredents
    }

    func appendWithNewLineCharacter(value: String) -> String {
        return value + "\n"
    }

}
