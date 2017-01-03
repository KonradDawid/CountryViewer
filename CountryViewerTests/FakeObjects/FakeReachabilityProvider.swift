//
//  FakeReachabilityProvider.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
@testable import CountryViewer

class FakeReachabilityProvider: ReachabilityProviderProtocol {
    
    let isConnected: Bool
    
    init(isConnected: Bool) {
        self.isConnected = isConnected
    }
}

