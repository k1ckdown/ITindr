//
//  UserProfileCD+CoreDataProperties.swift
//  
//
//  Created by Ivan Semenov on 10.06.2024.
//
//

import Foundation
import CoreData


extension UserProfileCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfileCD> {
        return NSFetchRequest<UserProfileCD>(entityName: "UserProfileCD")
    }

    @NSManaged public var aboutMyself: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var topics: NSSet

}

// MARK: Generated accessors for topics
extension UserProfileCD {

    @objc(addTopicsObject:)
    @NSManaged public func addToTopics(_ value: TopicCD)

    @objc(removeTopicsObject:)
    @NSManaged public func removeFromTopics(_ value: TopicCD)

    @objc(addTopics:)
    @NSManaged public func addToTopics(_ values: NSSet)

    @objc(removeTopics:)
    @NSManaged public func removeFromTopics(_ values: NSSet)

}
