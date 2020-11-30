//
//  DetailedCell.swift
//  Fictive
//
//  Created by Prof Ahyox on 28/11/2020.
//

import UIKit

class DetailedCell: UITableViewCell {
    
    
    @IBOutlet weak var phaseIcon: UIImageView!
    
    @IBOutlet weak var phaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
