//
//  NetworkReachabiltyNotifier.swift
//  iOSProficiencyExercise
//
//  Created by Vaneet Modgill on 20/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import Foundation
import Reachability

protocol NetworkReachabilityNotifierDelegate:class {
    func networkReachable(isReachable:Bool, rechableType:NetworkReachabilityNotifier.ReachableType)
}

class NetworkReachabilityNotifier:NSObject{
    
    enum ReachableType {
        case Wifi
        case Cellular
        case Unknown
    }
    
    let reachability = try? Reachability()
    weak var delegate:NetworkReachabilityNotifierDelegate?
    
    func initateNotification(){
        
        reachability?.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            var currentType:ReachableType = .Unknown
            if reachability.connection == .wifi {
                currentType = .Wifi
            }
            if reachability.connection == .cellular {
                currentType = .Cellular
            }
            self.delegate?.networkReachable(isReachable: true, rechableType: currentType)
        }
        reachability?.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            self.delegate?.networkReachable(isReachable: false, rechableType: .Unknown)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

    }
}
