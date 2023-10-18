import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    // MARK: - Methods:
    private func setupTabs() {
        let trackVC = createNav(with: "Трекеры", and: UIImage(named: "Record"), from: TrackersViewController())
        let statsVC = createNav(with: "Статистика", and: UIImage(named: "Statistics"), from: StatisticsViewController())
        self.setViewControllers([trackVC, statsVC], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, from vc: UIViewController) -> UINavigationController {
        let trackersNav = UINavigationController(rootViewController: vc)
        trackersNav.tabBarItem.title = title
        trackersNav.tabBarItem.image = image
        trackersNav.navigationBar.tintColor = .YPBlack
        trackersNav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Plus"), style: .plain, target: self, action: #selector(createHabitOrEvent))
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        return trackersNav
    }
    
    @objc private func createHabitOrEvent() {
        self.present(CreatingViewController(), animated: true)
    }
}
