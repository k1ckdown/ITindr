//
//  TopicCD+Mapping.swift
//  UserData
//
//  Created by Ivan Semenov on 10.06.2024.
//

import CoreData
import TopicDomain

public extension TopicCD {
    
    convenience init(_ topic: Topic, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = topic.id
        title = topic.title
    }
    
    func toDomain() -> Topic {
        Topic(id: id, title: title)
    }
}
