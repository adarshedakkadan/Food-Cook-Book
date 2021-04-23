//
//  FCBSearchViewController.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit
import KSToastView
import SVProgressHUD

class FCBSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "FCBHomeProductCollectionViewCell"
    var mealsData = [FCBMealDetails]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBaritem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismissSearch))
        self.navigationItem.leftBarButtonItem = navBaritem
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: Any) {
        self.search(name: self.searchBar.text ?? "")
    }
    
    @objc func dismissSearch() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FCBSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return mealsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FCBHomeProductCollectionViewCell
        cell.mealsInfo = self.mealsData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destinationViewController = self.storyboard?.instantiateViewController(identifier: "FCBFoodDetailsViewController") as? FCBFoodDetailsViewController {
            destinationViewController.identifer = self.mealsData[indexPath.row].idMeal
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2-10, height: 221)
    }

}

//MARK : API
extension FCBSearchViewController {
    
    fileprivate func search(name: String) {
        SVProgressHUD.show()
        FCBSearchFoodService().request(name: name) { [weak self] (status, result) in
            guard let _ = self else { return }
            guard let response = result as? FCBSearch else {
                KSToastView.ks_showToast(FCBStrings.errorServer)
                return
            }
            if response.meals.count > 0 {
                SVProgressHUD.dismiss()
                self?.mealsData.removeAll()
                self?.mealsData.append(contentsOf: response.meals)
            } else {
                KSToastView.ks_showToast(FCBStrings.noMealsFound)
                SVProgressHUD.dismiss()
            }
            self?.collectionView.reloadData()
        }
    }
    
}
