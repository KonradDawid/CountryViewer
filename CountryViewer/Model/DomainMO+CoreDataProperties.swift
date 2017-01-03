//
//  DomainMO+CoreDataProperties.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData


extension DomainMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DomainMO> {
        return NSFetchRequest<DomainMO>(entityName: "DomainMO");
    }

    @NSManaged public var name: String?
    @NSManaged public var country: CountryMO?

}
