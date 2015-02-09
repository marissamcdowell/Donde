//
//  DondeMeVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

class DondeMeVC: UIViewController, UITextViewDelegate,UITextFieldDelegate{
    
    // UI Components
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var radiusToDestinationTextField: UITextField!
    @IBOutlet weak var contactNameTextField: UITextField!
    
    @IBOutlet weak var messageToSendTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.containerView.layer.cornerRadius = 20
        self.destinationTextField.layer.cornerRadius = 10
        self.destinationTextField.layer.borderWidth = 2
        self.destinationTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.destinationTextField.delegate = self
        self.radiusToDestinationTextField.layer.borderWidth = 2
        self.radiusToDestinationTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.radiusToDestinationTextField.delegate = self
        self.radiusToDestinationTextField.layer.cornerRadius = 10
        self.messageToSendTextField.layer.borderWidth = 2
        self.messageToSendTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.messageToSendTextField.delegate = self
        self.messageToSendTextField.layer.cornerRadius = 10
        self.contactNameTextField.layer.borderWidth = 2
        self.contactNameTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.contactNameTextField.layer.cornerRadius = 10
        self.contactNameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForKeyboardNotifications ()-> Void   {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications () -> Void {
        let center:  NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
        
    }
    
    
    func keyboardWasShown (notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.frame
        
        //if( keyboardSize != nil ){
        var keyHeight:CGFloat = 224.0
            let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollview.contentInset.top, 0, keyHeight, 0)
            
            self.scrollview.contentInset = insets
            self.scrollview.scrollIndicatorInsets = insets
            
            self.scrollview.contentOffset = CGPointMake(self.scrollview.contentOffset.x, self.scrollview.contentOffset.y + keyHeight)
        //}
    }
    
    func keyboardWillBeHidden (notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.frame
        
        //if( keyboardSize != nil ){
            let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollview.contentInset.top, 0, 0, 0)
            
            self.scrollview.contentInset = insets
            self.scrollview.scrollIndicatorInsets = insets
        //}
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        self.deregisterFromKeyboardNotifications()
        
    }
    
    @IBAction func addButtonClicked(sender: UIButton) {
    }
    @IBAction func cancelButtonClicked(sender: UIButton) {
    }

    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Message to send" {
            textView.text = ""
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowLocation" {
            println(segue.destinationViewController.description)
            let viewController:MapVC = segue.destinationViewController as MapVC
            //            let mapVC = segue.destinationViewController as MapVC
            let destinationStr:String = self.destinationTextField.text
            viewController.destAddress = destinationStr
            viewController.radius =  (radiusToDestinationTextField.text as NSString).doubleValue
            viewController.group = contactNameTextField.text
        }
    }
    
    @IBAction func unwindToCreateDonde(segue: UIStoryboardSegue) {
        println("ID \(segue.identifier)")
        if segue.identifier == "ShowLocation" {
            println("Unwinding")
        }
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
