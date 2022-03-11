//
//  CoreDataStack.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import CoreData

func createContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let containter = NSPersistentContainer(name: "CoreData")
    containter.loadPersistentStores { _, error in
        guard error == nil else {
            fatalError("Failed to load store: \(error!)")
        }
        DispatchQueue.main.async {
            completion(containter)
        }
    }
}

