//
//  FriendSettingsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

class FriendSettingsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate {
    
    // UI Components
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var friendCircleView: UIView!
    @IBOutlet weak var friendCircleLabel: UITextField!
    
    @IBOutlet weak var checkboxCircleView: UIView!
    @IBOutlet weak var checkbox1Button: UIButton!
    @IBOutlet weak var checkbox2Button: UIButton!
    @IBOutlet weak var checkbox3Button: UIButton!
    
    @IBOutlet weak var checkbox1Label: UILabel!
    @IBOutlet weak var checkbox2Label: UILabel!
    @IBOutlet weak var checkbox3Label: UILabel!
    
    
    @IBOutlet weak var relationshipCircleView: UIView!
    @IBOutlet weak var relationshipTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let relationshipPicker:UIPickerView = UIPickerView()
    let relationshipArray:[String] = ["","Parent","Sibling","Best Friend","Friend","Family","Bae","Coworker","Other"]
    
    
    var friendsToSet:[String]!
    
    var currentFriendDetails:NSMutableDictionary = ["name":"",
        "relationship":"",
        "DondeMe":"",
        "AlertMe":"",
        "MiJourney":""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.checkboxCircleView.layer.cornerRadius = self.checkboxCircleView.frame.size.width/2
        self.checkboxCircleView.layer.borderWidth = 1
        self.checkboxCircleView.layer.borderColor = dondeAsphaltColor.CGColor
        self.checkboxCircleView.clipsToBounds = true
        self.checkboxCircleView.hidden = true
        
        self.friendCircleView.layer.cornerRadius = self.friendCircleView.frame.size.width/2
        self.friendCircleView.layer.borderWidth = 2
        self.friendCircleView.layer.borderColor = dondeAsphaltColor.CGColor
        self.friendCircleView.clipsToBounds = true
        
        self.relationshipCircleView.layer.cornerRadius = self.relationshipCircleView.frame.size.width/2
        self.relationshipCircleView.layer.borderWidth = 2
        self.relationshipCircleView.layer.borderColor = dondeAsphaltColor.CGColor
        self.relationshipCircleView.clipsToBounds = true
        self.relationshipCircleView.hidden = false
        
        self.friendCircleLabel.layer.borderWidth = 1
        self.friendCircleLabel.layer.borderColor = dondeAsphaltColor.CGColor
        self.friendCircleLabel.layer.cornerRadius = 10
        self.friendCircleLabel.text = friendsToSet[0]
        
        self.currentFriendDetails["name"] = friendsToSet[0]
        
        self.relationshipTextField.layer.borderWidth = 1
        self.relationshipTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.relationshipTextField.layer.cornerRadius = 10
        self.relationshipTextField.inputView = relationshipPicker
        
        
        relationshipPicker.delegate = self
        relationshipPicker.dataSource = self
        
        var doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "keyboardDoneClicked")
        var toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(doneBtn)
        toolbar.items = items
        //doneToolbar.sizeToFit()
        self.relationshipTextField.inputAccessoryView = toolbar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardDoneClicked()
    {
        relationshipTextField.resignFirstResponder()
    }
    
    @IBAction func checkboxClicked(sender: UIButton) {
        if(sender.selected == false){
            sender.selected = true;
        } else {
            sender.selected = false;
        }
    }
    
    @IBAction func backButtonClicked(sender: UIButton) {
        performSegueWithIdentifier("backToFriendList", sender: self)
    }
    @IBAction func nextButtonClicked(sender: UIButton) {
        if( sender.titleLabel?.text == "Assign" && contains(relationshipArray,relationshipTextField.text) ){
            relationshipCircleView.hidden = true
            checkboxCircleView.hidden = false
            if( friendsToSet.count > 1){
                nextButton.setTitle("Next", forState: UIControlState.Normal)
            } else {
                nextButton.setTitle("Done", forState: UIControlState.Normal)
            }
            
            self.currentFriendDetails["relationship"] = self.relationshipTextField.text
            
            if self.relationshipTextField.text == "Best Friend" {
                checkbox1Button.selected = true
                checkbox3Button.selected = true
            }
            
            var newX:CGFloat = (self.view.frame.size.width - self.checkboxCircleView.frame.size.width) / 2
            UIView.animateWithDuration(1.0, animations: {
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                
                self.checkboxCircleView.frame = CGRect(x: -10, y: self.checkboxCircleView.frame.origin.y, width: self.checkboxCircleView.frame.size.width, height: self.checkboxCircleView.frame.size.height)
            })
            
            self.friendCircleView.frame = CGRect(x:0, y: self.friendCircleView.frame.origin.y, width: self.friendCircleView.frame.size.width, height: self.friendCircleView.frame.size.height)
            UIView.animateWithDuration(1.0, animations: {
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                
                self.friendCircleView.frame = CGRect(x: newX+40, y: self.friendCircleView.frame.origin.y, width: self.friendCircleView.frame.size.width, height: self.friendCircleView.frame.size.height)
            })
            
        } else if( sender.titleLabel?.text == "Next" ){
            
            collectCheckData()
            
            friendsToSet.removeAtIndex(0)
            
            // if more friends to go through
            if( friendsToSet.count > 0 ){
                currentFriendDetails = ["name":friendsToSet[0],
                    "relationship":"",
                    "DondeMe":"",
                    "AlertMe":"",
                    "MiJourney":""
                ]
                nextButton.setTitle("Assign", forState: UIControlState.Normal)
                relationshipCircleView.hidden = false
                checkboxCircleView.hidden = true
                friendCircleLabel.text = friendsToSet[0]
                checkbox1Button.selected = false
                checkbox2Button.selected = false
                checkbox3Button.selected = false
                relationshipTextField.text = nil
            }
            
        } else if( sender.titleLabel?.text == "Done" ){
            collectCheckData()
            performSegueWithIdentifier("friendSettingsToHome", sender: self)
        }else {
            var alert = UIAlertView(title: "Not so fast", message: "Choose a relationship first!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    func collectCheckData() {
        var box1 = checkbox1Button.selected
        var box2 = checkbox2Button.selected
        var box3 = checkbox3Button.selected
        
        self.currentFriendDetails["DondeMe"] = box1.description
        self.currentFriendDetails["AlertMe"] = box2.description
        self.currentFriendDetails["MiJourney"] = box3.description
        //
        //            if( !box2 ){
        //                DondeUtils().addFriend(self.currentFriendDetails)
        //            } else {
        //                showAlertOptions()
        //            }
        
        //DondeUtils().addFriend(self.currentFriendDetails)
        //print(self.currentFriendDetails)
        var defaults = NSUserDefaults.standardUserDefaults()
        var friendsArrayOpt:NSMutableArray? = defaults.objectForKey("userFriends")?.mutableCopy() as? NSMutableArray
        if let friendsArray = friendsArrayOpt {
            friendsArray.addObject(self.currentFriendDetails)
            defaults.setObject(friendsArray, forKey: "userFriends")
        } else {
            var friendsArray = NSMutableArray()
            friendsArray.addObject(self.currentFriendDetails)
            defaults.setObject(friendsArray, forKey: "userFriends")
        }
    }
    
    func showAlertOptions() {
        println("alert options")
    }
    
    // picker view stuff
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationshipArray.count
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        relationshipTextField.text = relationshipArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return relationshipArray[row]
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
