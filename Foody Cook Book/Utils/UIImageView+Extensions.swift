//
//  FCBImageVIewExtensions.swift
//  Foody Cook Book
//
//  Created by Adarsh Manoharan on 23/04/3 R.
//


import UIKit
import Kingfisher

extension UIImageView {
    //load from url
    func loadImage(`with` urlString: String) {
        guard let url = URL.init(string: urlString) else {return}
        self.kf.setImage(with: url, completionHandler:  { result in
            switch result {
            case .success:
                print("suucess")
            case .failure(let error):
                print(error)
                self.kf.cancelDownloadTask()
                self.image = #imageLiteral(resourceName: "placeholder")
                return
            }
        })
    }
}


