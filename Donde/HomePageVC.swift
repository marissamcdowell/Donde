//
//  HomePageVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/7/15.
//
//

import UIKit

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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dondeMeClicked(sender: UIButton) {
        if( !DondeUtils().doesUserHaveFriends() ){
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
