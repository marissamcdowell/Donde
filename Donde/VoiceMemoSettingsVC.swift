//
//  VoiceMemoSettingsVC.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit

class VoiceMemoSettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    let relationshipArray:[String] = ["","Parent","Sibling","Best Friend","Friend","Family","Bae","Coworker","Other"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "SwitchCell")
        self.tableView.tableFooterView?.frame = CGRectZero
        self.nameTextField.layer.cornerRadius = 10
        self.tableView.rowHeight = 44.0
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
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func doneClicked(sender: AnyObject) {
        performSegueWithIdentifier("doneRecording", sender: self)
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
