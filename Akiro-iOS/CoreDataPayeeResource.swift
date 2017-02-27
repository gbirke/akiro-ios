//
//  CoreDataPayeeResource.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 27.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataPayeeResource: PayeeResource {
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpenseTracker")
        container.loadPersistentStores() {
            (storeDescription, error ) in
            
            if let error = error {
                let nserror = error as NSError
                print("Database init error: \(nserror.localizedDescription)")
            }
        }
        return container
    }()
    
    func insert(withName: String) -> Payee {
        let context = persistentContainer.viewContext
        let payee = NSEntityDescription.insertNewObject(forEntityName: "Payee", into: context) as! Payee
        payee.name = withName
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Database save error: \(nserror.localizedDescription)")
            }
        }
        return payee
    }
    
    func getList() -> [Payee] {
        var payees: [Payee] = []
        let request: NSFetchRequest<Payee> = Payee.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            try payees = persistentContainer.viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Database query error: \(nserror.localizedDescription)")
        }
        return payees
    }
    
}
