//
//  FooterTableViewCell.swift
//  TestProject
//
//  Created by galiev nail on 10.06.2021.
//

import UIKit

class FooterTableViewCell: UITableViewCell {
    static let identifier = "cell2"

    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
