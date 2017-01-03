//
//  ReachabilityProvider.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import Reachability


protocol ReachabilityProviderProtocol {
    var isConnected: Bool { get }
}

class ReachabilityProvider: ReachabilityProviderProtocol {
    
    var isConnected: Bool {
        let reachability = Reachability(hostname: "http://google.pl")
        return reachability?.isReachable() ?? true
    }
}

