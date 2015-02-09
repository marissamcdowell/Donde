//
//  DondeMeVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

class DondeMeVC: UIViewController, UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
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
    
    let relationshipPicker:UIPickerView = UIPickerView()
    let relationshipArray:[String] = ["","Parent","Sibling","Best Friend","Friend","Family","Bae","Coworker","Other"]
    
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
        self.contactNameTextField.layer.borderWidth = 2
        self.contactNameTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.contactNameTextField.layer.cornerRadius = 10
        self.contactNameTextField.delegate = self
        
        relationshipPicker.delegate = self
        relationshipPicker.dataSource = self
        
        self.contactNameTextField.inputView = relationshipPicker
        
        var doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "keyboardDoneClicked")
        var toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(doneBtn)
        toolbar.items = items
        //doneToolbar.sizeToFit()
        self.contactNameTextField.inputAccessoryView = toolbar
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
    
    @IBAction func dondeClicked(sender: UIButton) {
        
        if( (destinationTextField.text != nil && destinationTextField.text != ""  ) && (radiusToDestinationTextField.text != nil && radiusToDestinationTextField.text != ""   ) && (contactNameTextField.text != nil && contactNameTextField.text != ""  )){
            println(destinationTextField.text)
            println(radiusToDestinationTextField.text)
            println(contactNameTextField.text)
            performSegueWithIdentifier("goToMap", sender: self)
        } else {
            var alert = UIAlertView(title: "Not so fast", message: "Fill out the fields first!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    func keyboardDoneClicked()
    {
        contactNameTextField.resignFirstResponder()
    }
    
    
    func keyboardWasShown (notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.frame
        
        //if( keyboardSize != nil ){
        
//        if( self.contactNameTextField.frame.size.height+self.contactNameTextField.frame.origin.y <  ){
//            
//        }
//        
//        var keyHeight:CGFloat = 224.0
//            let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollview.contentInset.top, 0, keyHeight, 0)
//            
//            self.scrollview.contentInset = insets
//            self.scrollview.scrollIndicatorInsets = insets
//            
//            self.scrollview.contentOffset = CGPointMake(self.scrollview.contentOffset.x, self.scrollview.contentOffset.y + keyHeight)
//        //}
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
        if segue.identifier == "goToMap" {
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
        if segue.identifier == "goToMap" {
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
    
    // picker view stuff
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationshipArray.count
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        contactNameTextField.text = relationshipArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return relationshipArray[row]
    }

}
