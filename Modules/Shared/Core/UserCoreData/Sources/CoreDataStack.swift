//
//  CoreDataStack.swift
//  UserCoreData
//
//  Created by Ivan Semenov on 09.06.2024.
//

import CoreData
import Foundation

public final class CoreDataStack {

    public static let shared = CoreDataStack()

    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        guard
            let modelUrl = Bundle.module.url(forResource: Constants.modelName, withExtension: Constants.modelExtension),
            let model = NSManagedObjectModel(contentsOf: modelUrl)
        else { fatalError("Failed to create ManagedObjectModel") }

        let container = NSPersistentContainer(name: Constants.modelName, managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }

        return container
    }()

    private init() {}
}

// MARK: - Public methods

public extension CoreDataStack {

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        backgroundContext.perform { [weak self] in
            if let self { block(backgroundContext) }
        }
    }
}

// MARK: - Constants

private extension CoreDataStack {

    enum Constants {
        static let modelName = "User"
        static let modelExtension = "momd"
    }
}
