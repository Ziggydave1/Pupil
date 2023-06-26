//
//  PersistenceController.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/7/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let alias1 = Alias(context: viewContext)
        alias1.name = "AP Calculus BC"
        alias1.icon = "sum"
        
        let alias2 = Alias(context: viewContext)
        alias2.name = "AP Literature"
        
        let alias3 = Alias(context: viewContext)
        alias3.name = "AP Government"
        
        let link1 = AliasLink(context: viewContext)
        link1.key = "AP CALC BC (380852)"
        link1.value = alias1
        
        let link2 = AliasLink(context: viewContext)
        link2.key = "AP ENG LIT COMP 12 (250642)"
        link2.value = alias2
        
        let link3 = AliasLink(context: viewContext)
        link3.key = "AP US GOV/POL (13016)"
        link3.value = alias2
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PupilStorage")
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: App_Group)!
        let storeURL = containerURL.appendingPathComponent("PupilStorage.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        
        container.persistentStoreDescriptions = [description]
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func aliasLink(for key: String) -> AliasLink? {
        let request = AliasLink.fetchRequest()
        request.predicate = NSPredicate(format: "key = %@", key)
        
        
        let links = try? container.viewContext.fetch(request)
        
        if let links, let link = links.first {
            return link
        } else {
            return nil
        }
    }
    
    func alias(for key: String) -> Alias? {
        let request = AliasLink.fetchRequest()
        request.predicate = NSPredicate(format: "key = %@", key)
        
        
        let links = try? container.viewContext.fetch(request)
        
        if let links, let link = links.first, let alias = link.value {
            return alias
        } else {
            return nil
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
}
