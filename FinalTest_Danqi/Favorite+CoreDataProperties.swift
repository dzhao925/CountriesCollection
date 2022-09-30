//
//  Favorite+CoreDataProperties.swift
//  FinalTest_Danqi
//
//  Created by Danqi Zhao on 2022-04-15.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var population: Int32

}

extension Favorite : Identifiable {

}
