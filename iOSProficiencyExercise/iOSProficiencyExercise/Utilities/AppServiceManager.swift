//
//  AppServiceManager.swift
//  iOSProficiencyExercise
//
//  Created by Vaneet Modgill on 20/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import Foundation
import UIKit
class AppServiceManager: NSObject {
    lazy var networkReachabilityNotifier:NetworkReachabilityNotifier = NetworkReachabilityNotifier()
    lazy var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init() {
        super.init()
        networkReachabilityNotifier.delegate = self
    }
    
    func initiateAppServices() {
        initiateNetworkReachabilityObserver()
    }
    
    
}




extension(AppServiceManager):NetworkReachabilityNotifierDelegate{
    
    func initiateNetworkReachabilityObserver(){
        networkReachabilityNotifier.initateNotification()
    }
    
    //MARK:- DELEGATE METHOD(S)
    
    func networkReachable(isReachable: Bool, rechableType: NetworkReachabilityNotifier.ReachableType) {
        if isReachable{
    
        }
        else{
        
            UIApplication.shared.keyWindow!.rootViewController!.view.makeToast("Internet connection is not available. Please try again later.", duration: 2.0, position: ToastPosition.bottom, title: nil, image: nil, style: ToastManager.shared.style) { (completion) in
            }

        }
    }
}
