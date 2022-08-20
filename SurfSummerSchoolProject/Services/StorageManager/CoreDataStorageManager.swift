//
//  CoreDataStorageManager.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 14.08.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext


    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    
    func fetchData(completion: (Result<[FavoriteItem], Error>) -> Void) {
        let fetchRequest = FavoriteItem.fetchRequest()
        
        do {
            let pic = try self.viewContext.fetch(fetchRequest)
            completion(.success(pic))
        } catch let error {
            completion(.failure(error))
        }
    }
    private var pics: [FavoriteItem] = []
    
    private func ff() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let pics):
                self.pics = pics
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   
    
    func addPictureFavoriteStatus(model: DetailItemModel) {

        ff()
//        let pic = pics[0]
//
//        pic.id = model.id
//        pic.favorite = model.isFavorite
        
        print("TEST")
        if pics.isEmpty {
            print("NEW START ID")

            let pic = FavoriteItem(context: viewContext)
            pic.id = model.id
            pic.favorite = model.isFavorite
            saveContext()
        } else if pics.contains(where: { $0.id == model.id }) == true {
            for elements in 0..<pics.count {
                if model.id == pics[elements].id {
                    pics[elements].favorite.toggle()
                    saveContext()
                    
                    print("----------------------")
                    print("id выбранного элемента \(model.id)")
//                    print("Статус выбранного элемента \(model.isFavorite)")
                    print("id целевого элемента \(pics[elements].id ?? "0")")
                    print("Статус целевого элемента: \(pics[elements].favorite)")
                    print("Количество элементов: \(pics.count)")
                    print("----------------------")
            
            
        }
            }
        } else {
            print("NEW ID")
            let pic = FavoriteItem(context: viewContext)
            pic.id = model.id
            pic.favorite = model.isFavorite
            saveContext()
        }
        print("END")

    }
    
    func changeFavoriteStatus(model: DetailItemModel) {
        ff()
        if pics.contains(where: { $0.id == model.id }) == true {
            viewContext.delete(pics[model.id])
            
        }
    }
    
    
    
    
    
//    func checkIfElementFavorite(id: String) -> Bool {
//
//    }
            


    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
