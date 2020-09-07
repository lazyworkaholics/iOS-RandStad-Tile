//
//  ReachabilityMock.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityMock: Reachability
{
    var reachableViaWifi = false
    var reachableViaWWAN = false
    
    override func isReachableViaWiFi() -> Bool {
        return reachableViaWifi
    }
    
    override func isReachableViaWWAN() -> Bool {
        return reachableViaWWAN
    }

}
