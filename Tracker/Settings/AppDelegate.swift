import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties:
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrackerModels")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } 
        })
        return container
    }()
    
    var window: UIWindow?
    
    // MARK: - Methods:
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = OnboardingViewController() //TabBarViewController()
        window?.makeKeyAndVisible()
        DaysTransformer.register()
        ColorTransformer.register()
        
        return true
    }
    
    
}

