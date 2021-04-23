//
//  FCBHomeCollectionViewController.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit
import KSToastView
import SVProgressHUD
import DropDown

protocol FCBCollectionViewActionDelegate: class {
    func tapOnFavorite(model: FCBHomeMeal, isFavorite: Bool)
}

class FCBHomeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var filterBarButtonItem: UIBarButtonItem!

    let reuseIdentifier = "FCBHomeProductCollectionViewCell"
    var mealsData = [FCBHomeMeal]()
    var mealCategories = [String]()
    let dropDown = DropDown()
    var favoriteMeals = [FCBHomeMeal]()
    var isFavoritePresent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategories()
        getFavorites()
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return mealsData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCBHomeProductCollectionViewCell
        if indexPath.row < mealsData.count {
            cell.value = self.mealsData[indexPath.row]
            cell.delegate = self
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destinationViewController = self.storyboard?.instantiateViewController(identifier: "FCBFoodDetailsViewController") as? FCBFoodDetailsViewController {
            destinationViewController.identifer = self.mealsData[indexPath.row].idMeal
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
        
    }

    @IBAction func searchButton(_ sender: Any) {
        if let destinationViewController = self.storyboard?.instantiateViewController(identifier: "FCBSearchViewNavController") as? UINavigationController {
            self.present(destinationViewController, animated: true)
        }
    }

    @IBAction func favoriteMeals(_ sender: Any) {
        self.mealsData.removeAll()
        self.isFavoritePresent = true
        self.getFavorites()
        if self.favoriteMeals.count > 0 {
            self.changeMealsStatus(meals: self.favoriteMeals)
        } else {
            KSToastView.ks_showToast(FCBStrings.noFavoriteMeals)
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        dropDown.anchorView = filterBarButtonItem
        dropDown.textFont = UIFont.boldSystemFont(ofSize: 15)
        dropDown.dataSource = mealCategories
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.mealsData.removeAll()
            self.getProducts(category: item)
        }
        dropDown.show()
    }
}

extension FCBHomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2-10, height: 221)
    }
}

//MARK : API
extension FCBHomeCollectionViewController {
    
    fileprivate func getFavorites() {
        if let meals = FCBDBHelper.getMeals() {
            self.favoriteMeals = meals
        }
    }
    
    fileprivate func getProducts(category: String) {
        self.isFavoritePresent = false
        FCBHomeFoodService().request(name: category) { [weak self] (status, result) in
            guard let _ = self else { return }
            guard let response = result as? FCBHomeMealModel else {
                KSToastView.ks_showToast(FCBStrings.errorServer)
                return
            }
            if response.meals.count > 0 {
                self?.changeMealsStatus(meals: response.meals)
                SVProgressHUD.dismiss()
            } else {
                KSToastView.ks_showToast(FCBStrings.errorData)
           
                SVProgressHUD.dismiss()
            }
        }
    }
    
    fileprivate func changeMealsStatus(meals: [FCBHomeMeal]) {
        self.mealsData.removeAll()
        var resultMeals = [FCBHomeMeal]()
        meals.forEach { item in
            var isFavorite = false
            self.favoriteMeals.forEach { favoriteItem in
                if item.idMeal == favoriteItem.idMeal {
                    isFavorite = true
                }
            }
            resultMeals.append(FCBHomeMeal(strMeal: item.strMeal, strMealThumb: item.strMealThumb, idMeal: item.idMeal, isFavorite: isFavorite))
        }
        self.mealsData.append(contentsOf: resultMeals)
        self.collectionView.reloadData()
    }
    
    fileprivate func getCategories() {
        SVProgressHUD.show()
        FCBCategoryService().request { [weak self] (status, result) in
            guard let response = result as? FCBFoodCategoriesModel else {
                KSToastView.ks_showToast(FCBStrings.errorServer)
                return
            }
            let categories = response.meals.shuffled()
            categories.forEach { item in
                self?.mealCategories.append(item.strCategory)
            }
            if categories.count > 1 {
                self?.getProducts(category: categories.first?.strCategory ?? "")
                self?.getProducts(category: categories.last?.strCategory ?? "")
            } else {
                KSToastView.ks_showToast(FCBStrings.errorData)
                SVProgressHUD.dismiss()
            }
        }
    }
    
}
extension FCBHomeCollectionViewController: FCBCollectionViewActionDelegate {
    func tapOnFavorite(model: FCBHomeMeal, isFavorite: Bool) {
        if isFavorite {
            self.favoriteMeals.append(model)
        } else {
            if let index = favoriteMeals.firstIndex(where: { $0.idMeal == model.idMeal }) {
                self.favoriteMeals.remove(at: index)
                if isFavoritePresent {
                    self.mealsData.remove(at: index)
                }
            }
        }
        FCBDBHelper.storeValues(meals: self.favoriteMeals)
        self.changeMealsStatus(meals: self.mealsData)
    }
    
    
}
