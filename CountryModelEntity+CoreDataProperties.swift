//
//  CountryModelEntity+CoreDataProperties.swift
//  TestProject
//
//  Created by galiev nail on 12.06.2021.
//
//

import Foundation
import CoreData


extension CountryModelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryModelEntity> {
        return NSFetchRequest<CountryModelEntity>(entityName: "CountryModelEntity")
    }

    @NSManaged public var next: String?
    @NSManaged public var countries: NSSet?

}

// MARK: Generated accessors for countries
extension CountryModelEntity {

    @objc(addCountriesObject:)
    @NSManaged public func addToCountries(_ value: CountryEntity)

    @objc(removeCountriesObject:)
    @NSManaged public func removeFromCountries(_ value: CountryEntity)

    @objc(addCountries:)
    @NSManaged public func addToCountries(_ values: NSSet)

    @objc(removeCountries:)
    @NSManaged public func removeFromCountries(_ values: NSSet)

}

extension CountryModelEntity : Identifiable {

}
