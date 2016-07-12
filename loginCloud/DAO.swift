//
//  DAO.swift
//  loginCloud
//
//  Created by Andre Machado Parente on 7/11/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import Foundation
import CloudKit

public var auxID: String!


class DAO {
    
    func cloudAvailable()->(Bool)
    {
        if NSFileManager.defaultManager().ubiquityIdentityToken != nil{
            return true
        }
        else{
            return false
        }
    }
    
    func getCloudID(complete: (instance: CKRecordID?, error: NSError?) -> ()) {
        
        
        dispatch_async(dispatch_get_main_queue(),{
            
            let container = CKContainer.defaultContainer()
            container.fetchUserRecordIDWithCompletionHandler() {
                recordID, error in
                if error != nil {
                    print(error!.localizedDescription)
                    complete(instance: nil, error: error)
                } else {
                    print("fetched ID \(recordID?.recordName)")
                    auxID = recordID?.recordName
                    NSNotificationCenter.defaultCenter().postNotificationName("notificationIDReceived", object: nil)
                    complete(instance: recordID, error: nil)
                }
            }
           
        })
        
    }
    
    
}
