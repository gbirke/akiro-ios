//
//  CoreDataCategoryResource.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 27.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataCategoryResource: CategoryResource {
    
    var persistentContainer: NSPersistentContainer
    
    init(withContainer: NSPersistentContainer) {
        persistentContainer = withContainer
    }
    
    func getList() -> [Category] {
        var categories: [Category] = []
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "sortId", ascending: true)]
        do {
            try categories = persistentContainer.viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Database query error: \(nserror.localizedDescription)")
        }
        return categories
    }
    
    func initializeFromCSV(preloadUrl: URL?) {
        do {
            let content = try String(contentsOf: preloadUrl!, encoding: String.Encoding.utf8 )
            for (index, row)  in content.csvRows().enumerated() {
                let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: persistentContainer.viewContext) as! Category
                category.parent = row[0];
                category.name = row[1]
                category.sortId = Int16(index)
            }
        } catch {
            print("Error loading CSV data: \(error)")
        }
        saveContext()
    }
    
    private func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                let nserror = error as NSError
                print("Database save error: \(nserror.localizedDescription)")
            }
        }

    }
    
}
