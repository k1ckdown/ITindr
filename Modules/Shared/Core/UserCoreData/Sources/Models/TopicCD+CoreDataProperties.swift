//
//  TopicCD+CoreDataProperties.swift
//  
//
//  Created by Ivan Semenov on 10.06.2024.
//
//

import Foundation
import CoreData


extension TopicCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopicCD> {
        return NSFetchRequest<TopicCD>(entityName: "TopicCD")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension TopicCD {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserProfileCD)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserProfileCD)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
