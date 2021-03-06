//
//  ChooseFriendsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit
import CloudKit

class ChooseFriendsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // ui components
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var addFriendsButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // data properties
    var contactArray:[String] = ["Tim Jones","Bill Smith","Fred Fields"]
    var checkboxArray = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.contactsTableView.registerNib(UINib(nibName: "ChooseFriendCell", bundle: nil), forCellReuseIdentifier: "ChooseCell")
        self.contactsTableView.backgroundColor = dondeGreenColor
        self.contactsTableView.layer.cornerRadius = 25
        self.contactsTableView.rowHeight = 44.0
        self.contactsTableView.tableFooterView = UIView(frame: CGRectZero)
        self.contactsTableView.separatorColor = dondeAsphaltColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TABLE VIEW METHODS
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChooseFriendCell = tableView.dequeueReusableCellWithIdentifier("ChooseCell") as ChooseFriendCell
        cell.nameLabel?.text = self.contactArray[indexPath.row]
        checkboxArray.append(cell.checkboxButton)
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header:UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        header.backgroundColor = UIColor.clearColor()
        
        var headerLabel:UILabel = UILabel(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerLabel.text = "Add friends from contacts"
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.textColor = dondeAsphaltColor
        header.addSubview(headerLabel)
        return header
    }
    
    
    @IBAction func cancelClicked(sender: UIButton) {
    }
    
    @IBAction func addClicked(sender: UIButton) {
        var checkedFriends = [String]()
        for var i=0; i<contactArray.count;i++ {
            if( checkboxArray[i].selected ){
                checkedFriends.append(contactArray[i])
            }
        }
        if( checkedFriends.count == 0 ){
            var alert = UIAlertView(title: "Not so fast", message: "Select some friends to continue!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            performSegueWithIdentifier("goToFriendSettings", sender: self)
        }
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if( segue.identifier == "goToFriendSettings" ){
            
            var checkedFriends = [String]()
            for var i=0; i<contactArray.count;i++ {
                if( checkboxArray[i].selected ){
                    checkedFriends.append(contactArray[i])
                }
            }
            var segueVC = segue.destinationViewController as FriendSettingsVC
            segueVC.friendsToSet = checkedFriends
        } else if( segue.identifier == "backToHome" ){
            for var i=0; i<contactArray.count;i++ {
                checkboxArray[i].selected = false
            }
        }
    }
}
