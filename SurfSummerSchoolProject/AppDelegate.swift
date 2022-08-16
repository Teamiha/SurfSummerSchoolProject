//
//  AppDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 02.08.2022.
//

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "CoreData")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

    var window: UIWindow?
    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }

        startApplicationProccess()

        return true
    }

    func startApplicationProccess() {
        runLaunchScreen()

        if let tokenContainer = try? tokenStorage.getToken(), !tokenContainer.isExpired {
            runMainFlow()
        } else {
            let tempCredentials = AuthRequestModel(phone: "+71234567890", password: "qwerty")
            AuthService()
                .performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                    switch result {
                    case .success:
                        self?.runMainFlow()
                    case .failure:
                        // TODO: - Handle error, if token was not received
                        break
                    }
                }
        }
    }

    func runMainFlow() {
        DispatchQueue.main.async {
            self.window?.rootViewController = TabBarConfigurator().configure()
        }
    }

    func runLaunchScreen() {
        let lauchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main)
            .instantiateInitialViewController()

        window?.rootViewController = lauchScreenViewController
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveContext()
        }

}
