//
//  WeatherCollectionViewCell.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    static let identifier = String(describing: WeatherCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        locationLabel.text = nil
    }
    
    func setup(imageUrl: String, title: String, location: String) {
        imageView.download(from: imageUrl)
        titleLabel.text = title
        locationLabel.text = location
    }

}
