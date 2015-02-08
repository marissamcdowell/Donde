//
//  FriendSettingsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

class FriendSettingsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    let relationshipArray:[String] = ["Mother","Father","Brother","Sister","Cousin","Friend","Best Friend","Boyfriend","Girlfriend","Coworker","Other"]
    
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
        
        self.relationshipTextField.layer.borderWidth = 1
        self.relationshipTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.relationshipTextField.layer.cornerRadius = 10
        self.relationshipTextField.inputView = relationshipPicker
        
//        let button:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector(keyboardDoneClicked(<#sender: UIButton#>))
//        relationshipPicker.delegate = self
//        relationshipPicker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardDoneClicked(sender: UIButton) {
        
    }

    @IBAction func checkboxClicked(sender: UIButton) {
    }

    @IBAction func backButtonClicked(sender: UIButton) {
    }
    @IBAction func nextButtonClicked(sender: UIButton) {
        if( sender.titleLabel?.text == "Assign" ){
            relationshipCircleView.hidden = true
            checkboxCircleView.hidden = false
            nextButton.titleLabel?.text = "Next"
            var newX:CGFloat = (self.view.frame.size.width - self.checkboxCircleView.frame.size.width) / 2
            //self.checkboxCircleView.frame = CGRect(x:newX, y: self.checkboxCircleView.frame.origin.y, width: self.checkboxCircleView.frame.size.width, height: self.checkboxCircleView.frame.size.height)
            print(checkboxCircleView.frame.origin.x)
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
            print("future segue")
        }
    }
    
    // picker view stuff
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationshipArray.count
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        print(relationshipArray[row])
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
