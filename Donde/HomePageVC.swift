//
//  HomePageVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit
import CloudKit

class HomePageVC: UIViewController, UIAlertViewDelegate {
    
    // ui components
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var dondeMeButton: UIButton!
    @IBOutlet weak var alertMeButton: UIButton!
    @IBOutlet weak var miJourneyButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set up buttons
        let buttonArray:[UIButton] = [dondeMeButton,alertMeButton,miJourneyButton]
        for button in buttonArray {
            button.layer.cornerRadius = 10
        }
        
        DondeCloudModel().getContacts()
        
        var rec = CKRecord(recordType:"TestRecord")
        rec.setObject("Hello", forKey: "TestString")
        var loc:CLLocation = CLLocation(latitude: 3.0, longitude: 18.0)
        rec.setObject(loc, forKey: "TestLoc")
        
        DondeCloudModel().publicDB.saveRecord(rec, completionHandler: { (record, error) in
            
            if error != nil {
                println("There was an error \(error.description)!")
                
            } else {
                var theRecord:CKRecord = record as CKRecord
                print(theRecord.recordID)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dondeMeClicked(sender: UIButton) {
        if( DondeUtils().doesUserHaveFriends() ){
            var alert = UIAlertView(title: "Not so fast", message: "Add some friends first!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            performSegueWithIdentifier("goToDondeMe", sender: self)
        }
    }
    
    @IBAction func alertMeClicked(sender: UIButton) {
        
    }

    @IBAction func miJourneyClicked(sender: AnyObject) {
        
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
