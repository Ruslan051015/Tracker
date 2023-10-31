import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: - Private properties:
    
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarsBorder()
        setupTabs()
    }
    
    // MARK: - Private methods:
    private func setupTabs() {
        let trackersNVC = UINavigationController(rootViewController: TrackersViewController())
        let statsNVC = UINavigationController(rootViewController: StatisticsViewController())
        
        trackersNVC.tabBarItem.title = "Трекеры"
        trackersNVC.tabBarItem.image = UIImage(named: "Record")
        statsNVC.tabBarItem.title = "Статистика"
        statsNVC.tabBarItem.image = UIImage(named: "Statistics")
        
        self.setViewControllers([trackersNVC, statsNVC], animated: true)
    }
    
  
    private func setTabBarsBorder() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = .YPGray
        tabBar.addSubview(lineView)
        tabBar.clipsToBounds = true
    }
}

