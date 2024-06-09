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

    private lazy var persistentContainer: NSPersistentContainer = {
        guard
            let modelUrl = Bundle.module.url(forResource: Constants.modelName, withExtension: Constants.modelExtension),
            let model = NSManagedObjectModel(contentsOf: modelUrl)
        else { fatalError("Failed to create ManagedObjectModel") }

        let persistentContainer = NSPersistentContainer(name: Constants.modelName, managedObjectModel: model)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }

        return persistentContainer
    }()

    private init() {}
}

// MARK: - Public methods

public extension CoreDataStack {

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}

// MARK: - Constants

private extension CoreDataStack {

    enum Constants {
        static let modelName = "User"
        static let modelExtension = "momd"
    }
}
