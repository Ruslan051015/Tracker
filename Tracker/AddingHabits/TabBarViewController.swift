import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: - Private properties:
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        picker.tintColor = .YPBlue
        
        return picker
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarsBorder()
        setupTabs()
    }
    
    // MARK: - Private methods:
    private func setupTabs() {
        let trackersVC = createTrackersNav(with: "Трекеры", and: UIImage(named: "Record"), from: TrackersViewController())
        let statsVC = createStatsNav(with: "Статистика", and: UIImage(named: "Statistics"), from: StatisticsViewController())
        self.setViewControllers([trackersVC, statsVC], animated: true)
    }
    
    private func createTrackersNav(with title: String, and image: UIImage?, from vc: UIViewController) -> UINavigationController {
        let trackersNav = UINavigationController(rootViewController: vc)
        trackersNav.tabBarItem.title = title
        trackersNav.tabBarItem.image = image
        trackersNav.navigationBar.tintColor = .YPBlack
        let rightButton = UIBarButtonItem(customView: datePicker)
        trackersNav.viewControllers.first?.navigationItem.rightBarButtonItem = rightButton
        trackersNav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Plus"), style: .plain, target: self, action: #selector(createHabitOrEvent))
        
        
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        return trackersNav
    }
    
    private func createStatsNav(with title: String, and image: UIImage?, from vc: UIViewController) -> UINavigationController {
        let statsNav = UINavigationController(rootViewController: vc)
        statsNav.tabBarItem.title = title
        statsNav.tabBarItem.image = image
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        
        return statsNav
    }
    
    @objc private func createHabitOrEvent() {
        self.present(CreatingViewController(), animated: true)
    }
    
    private func setTabBarsBorder() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = .YPGray
        tabBar.addSubview(lineView)
        tabBar.clipsToBounds = true
    }
}
