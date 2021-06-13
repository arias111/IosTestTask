//
//  CountriesTableViewCell.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    static let identifier = "cell"

    override func awakeFromNib() {
        super.awakeFromNib()
        countryNameLabel.adjustsFontSizeToFitWidth = true
        countryCapitalLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
