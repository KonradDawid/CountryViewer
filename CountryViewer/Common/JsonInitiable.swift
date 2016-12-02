//
//  JsonInitiable.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import SwiftyJSON


protocol JsonInitiable {
    init?(json: JSON)
}

extension JsonInitiable {
    
    static func arrayFromJson<T: JsonInitiable>(_ json: JSON) -> [T] {
        if let jsonArray = json.array {
            return jsonArray.flatMap(T.init)
        }
        return []
    }
}

