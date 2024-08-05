//
//  PersistenceController.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/7/23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    var enabled: Bool = false
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PupilStorage")
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: App_Group)!
        let storeURL = containerURL.appendingPathComponent("PupilStorage.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        
        container.persistentStoreDescriptions = [description]
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
//        container.loadPersistentStores { [weak self] storeDescription, error in
//            self?.enabled = error == nil
//        }
        
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
