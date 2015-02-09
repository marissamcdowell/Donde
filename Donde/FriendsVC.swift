//
//  FriendsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit

class FriendsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // ui components
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addMoreFriends:UIButton!
    
    var friendsArray:[NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.registerNib(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")

        let defaults = NSUserDefaults.standardUserDefaults()
        if let testArray : AnyObject? = defaults.objectForKey("userFriends") {
            //friendsArray? = testArray! as [NSDictionary]
            print(testArray)
        }
        
//        friendsArray = defaults.objectForKey("userFriends") as Dictionary
        
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friends = friendsArray {
            return friends.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FriendCell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as FriendCell
        
        if let friends = friendsArray {
            var friend:NSDictionary = friends[indexPath.row]
            cell.nameLabel?.text = friend.objectForKey("name")?.description
            cell.groupLabel?.text = friend.objectForKey("relationship")?.description
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 61.0
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
