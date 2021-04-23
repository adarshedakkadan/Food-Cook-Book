//
//  FCBHomeProductCollectionViewCell.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//

import UIKit

class FCBHomeProductCollectionViewCell: UICollectionViewCell {
    
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
    }
    
}
