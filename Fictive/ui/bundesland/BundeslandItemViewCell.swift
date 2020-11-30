//
//  BundeslandItemViewCell.swift
//  Fictive
//
//  Created by Prof Ahyox on 29/11/2020.
//

import UIKit

class BundeslandItemViewCell: UITableViewCell {
    
    @IBOutlet weak var bundeslandLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
