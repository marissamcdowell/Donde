//
//  ChooseFriendCell.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

class ChooseFriendCell: UITableViewCell {
    
    // ui components
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    @IBAction func clickCheckbox(sender: UIButton) {
        if(sender.selected == false){
            sender.selected = true;
        } else {
            sender.selected = false;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
