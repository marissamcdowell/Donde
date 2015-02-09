//
//  VoiceMemoSettingsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit
import CloudKit

class VoiceMemoSettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    let relationshipArray:[String] = ["Parent","Sibling","Best Friend","Friend","Family","Bae","Coworker","Other"]
    var switchArray = [UISwitch]()
    var file:CKAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")
        self.tableView.tableFooterView?.frame = CGRectZero
        self.nameTextField.layer.cornerRadius = 10
        self.nameTextField.delegate = self
        self.tableView.rowHeight = 44.0
        self.tableView.bounces = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table view stuff
    // TABLE VIEW METHODS
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.relationshipArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SwitchCell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as SwitchCell
        cell.relationshipLabel?.text = self.relationshipArray[indexPath.row]
        self.switchArray.append(cell.switchCell)
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func doneClicked(sender: AnyObject) {
        var index = 0
        
        if( nameTextField.text != nil ){
            var dict = ["name":nameTextField.text,
                "Parent":switchArray[0].on,
                "Sibling":switchArray[1].on,
                "BestFriend":switchArray[2].on,
                "Friend":switchArray[3].on,
                "Family":switchArray[4].on,
                "Bae":switchArray[5].on,
                "Coworker":switchArray[6].on,
                "Other":switchArray[7].on]
            
            println(dict)
            
            var rec = CKRecord(recordType:"Memo")
            rec.setObject(nameTextField.text, forKey: "Name")
            rec.setObject(switchArray[0].on, forKey: "Parent")
            rec.setObject(switchArray[1].on, forKey: "Sibling")
            rec.setObject(switchArray[2].on, forKey: "BestFriend")
            rec.setObject(switchArray[3].on, forKey: "Friend")
            rec.setObject(switchArray[4].on, forKey: "Family")
            rec.setObject(switchArray[5].on, forKey: "Bae")
            rec.setObject(switchArray[6].on, forKey: "Coworker")
            rec.setObject(switchArray[7].on, forKey: "Other")
            
            if let realfile = file {
                rec.setObject(realfile, forKey: "Memo")
            }
            
            
            DondeCloudModel().publicDB.saveRecord(rec, completionHandler: { (record, error) in
                
                if error != nil {
                    println("There was an error \(error.description)!")
                    
                } else {
                    var theRecord:CKRecord = record as CKRecord
                    print(theRecord.recordID)
                }
            })
            
            
            performSegueWithIdentifier("doneRecording", sender: self)
        } else {
            var alert = UIAlertView(title: "Not so fast", message: "Name your memo first!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
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
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
}
