//
//  TopicCD+Mapping.swift
//  UserData
//
//  Created by Ivan Semenov on 10.06.2024.
//

import CoreData
import TopicDomain
import ProfileDomain
import UserCoreData

extension TopicCD {
    convenience init(_ topic: Topic, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = topic.id
        title = topic.title
    }
}

extension TopicCD {
    func toDomain() -> Topic {
        Topic(id: id, title: title)
    }
}
