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
        
        let links = try? container.viewContext.fetch(request)
        
        return links?.first(where: { $0.key == key })
    }
    
    func alias(for key: String) -> Alias? {
        let link = aliasLink(for: key)
        
        return link?.value
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
}
