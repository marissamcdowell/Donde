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
    @IBOutlet weak var scrollviiew: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var radiusToDestinationTextField: UITextField!
    
    @IBOutlet weak var messageToSendTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.containerView.layer.cornerRadius = 20
        self.destinationTextField.layer.cornerRadius = 10
        self.destinationTextField.layer.borderWidth = 2
        self.destinationTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.radiusToDestinationTextField.layer.borderWidth = 2
        self.radiusToDestinationTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.radiusToDestinationTextField.layer.cornerRadius = 10
        self.messageToSendTextField.layer.borderWidth = 2
        self.messageToSendTextField.layer.borderColor = dondeAsphaltColor.CGColor
        self.messageToSendTextField.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonClicked(sender: UIButton) {
    }
    @IBAction func cancelButtonClicked(sender: UIButton) {
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
