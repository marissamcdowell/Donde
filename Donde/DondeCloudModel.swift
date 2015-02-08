//
//  DondeCloudModel.swift
//  Donde
//
//  Created by Marissa McDowell on 2/8/15.
//
//

import UIKit
import CloudKit

class DondeCloudModel: NSObject {
    
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    
    override init() {
        // 1
        container = CKContainer.defaultContainer()
        container.requestApplicationPermission(CKApplicationPermissions.PermissionUserDiscoverability, completionHandler: {
            applicationPermissionStatus, error in
            // check (applicationPermissionStatus == CKApplicationPermissionStatus.Granted)
        })
        // 2
        publicDB = container.publicCloudDatabase
        // 3
        privateDB = container.privateCloudDatabase
    }
   
    func getContacts() {
        let contactFinder = CKDiscoverAllContactsOperation()
        contactFinder.usesBackgroundSession = true
        contactFinder.queuePriority = NSOperationQueuePriority.Normal
        
        contactFinder.discoverAllContactsCompletionBlock = { (res:[AnyObject]!, error:NSError?) -> Void in
            print("in contacts completion")
        }
        container.addOperation(contactFinder)
    }
}