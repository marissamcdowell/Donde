//
//  FriendCell.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit

class FriendCell: UITableViewCell {
    
    // ui components
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
