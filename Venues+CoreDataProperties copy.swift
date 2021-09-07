//
//  Venues+CoreDataProperties.swift
//  
//
//  Created by Abhi on 06/09/21.
//
//

import Foundation
import CoreData


extension Venues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venues> {
        return NSFetchRequest<Venues>(entityName: "Venues")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?

}
