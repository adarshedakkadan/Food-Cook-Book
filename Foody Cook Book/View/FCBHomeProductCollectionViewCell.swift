//
//  FCBHomeProductCollectionViewCell.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit

class FCBHomeProductCollectionViewCell: UICollectionViewCell {
    var value: FCBHomeMeal! {
        didSet {
            self.productImageView.loadImage(with: value.strMealThumb)
            self.productNameLabel.text = value.strMeal
            self.isFavorite = value.isFavorite
        }
    }
    
    var mealsInfo: FCBMealDetails! {
        didSet {
            self.productImageView.loadImage(with: value.strMealThumb)
            self.productNameLabel.text = value.strMeal
            self.isFavorite = value.isFavorite
        }
    }
    
    var isFavorite: Bool? {
        didSet {
            if isFavorite ?? false {
                self.addFavouriteButton.tintColor = .red
            } else {
                self.addFavouriteButton.tintColor = .white
            }
        }
    }
    
    weak var delegate: FCBCollectionViewActionDelegate?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addFavouriteButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    
    func addBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func addFavouriteButtonAction(_ sender: Any) {
        if addFavouriteButton.tintColor == UIColor.white {
            delegate?.tapOnFavorite(model: self.value, isFavorite: true)
            addFavouriteButton.tintColor = UIColor.red
        } else {
            delegate?.tapOnFavorite(model: self.value, isFavorite: false)
            addFavouriteButton.tintColor = UIColor.white
        }
        
    }
    
}
