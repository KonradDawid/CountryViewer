//
//  CountryMO+CoreDataProperties.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData


extension CountryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryMO> {
        return NSFetchRequest<CountryMO>(entityName: "CountryMO");
    }

    @NSManaged public var capital: String?
    @NSManaged public var code: String?
    @NSManaged public var completed: Bool
    @NSManaged public var name: String?
    @NSManaged public var borders: NSSet?
    @NSManaged public var domains: NSSet?

}

// MARK: Generated accessors for borders
extension CountryMO {

    @objc(addBordersObject:)
    @NSManaged public func addToBorders(_ value: CountryMO)

    @objc(removeBordersObject:)
    @NSManaged public func removeFromBorders(_ value: CountryMO)

    @objc(addBorders:)
    @NSManaged public func addToBorders(_ values: NSSet)

    @objc(removeBorders:)
    @NSManaged public func removeFromBorders(_ values: NSSet)

}

// MARK: Generated accessors for domains
extension CountryMO {

    @objc(addDomainsObject:)
    @NSManaged public func addToDomains(_ value: DomainMO)

    @objc(removeDomainsObject:)
    @NSManaged public func removeFromDomains(_ value: DomainMO)

    @objc(addDomains:)
    @NSManaged public func addToDomains(_ values: NSSet)

    @objc(removeDomains:)
    @NSManaged public func removeFromDomains(_ values: NSSet)

}
