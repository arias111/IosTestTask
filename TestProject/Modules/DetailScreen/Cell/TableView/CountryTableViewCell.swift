//
//  CountryTableViewCell.swift
//  TestProject
//
//  Created by galiev nail on 10.06.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
