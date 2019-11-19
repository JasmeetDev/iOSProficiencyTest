//
//  ListingVCServiceManager.swift
//  iOSProficiencyExercise
//
//  Created by Jasmeet Singh on 18/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import Foundation
import TDResult
import TDWebService
import Alamofire

protocol ListingVCServiceManagerDelegate:class {
    func listingVCServiceManager(_ listingVCServiceManager: ListingVCServiceManager, didSuccessfullyGetContent content:Content)
    func completeProfileVCServiceManager(_  completeProfileVCServiceManager : ListingVCServiceManager, failedWithError  error:TDError)
}

class ListingVCServiceManager {
    //MARK:VARIABLE(S)
    weak var delegate:ListingVCServiceManagerDelegate?
    private var listingServiceManager = ListingServiceManager()
    
    func getContent() {
        listingServiceManager.call({ (result) in
            switch result {
            case .Success(let content):
                self.delegate?.listingVCServiceManager(self, didSuccessfullyGetContent: content)
                break
            case .Error(let error):
                self.delegate?.completeProfileVCServiceManager(self, failedWithError: error)
                break
            }
        })
    }
}

