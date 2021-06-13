//
//  ImageCollectionViewCell.swift
//  TestProject
//
//  Created by galiev nail on 10.06.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"

    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
