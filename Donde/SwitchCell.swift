//
//  SwitchCell.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit

class SwitchCell: UITableViewCell {
    
    // ui components
    @IBOutlet weak var relationshipLabel: UILabel!
    @IBOutlet weak var switchCell: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
