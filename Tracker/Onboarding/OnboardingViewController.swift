import UIKit

class OnboardingViewController: UIPageViewController {
    // MARK: - Properties:
    
    
    // MARK: - Private Properties:
    private lazy var pages: [UIViewController] = {
        let firstPage = FirstPageViewController()
        let secondPage = SecondPageViewController()
        
        return [firstPage, secondPage]
    }()
    
    private lazy var wowButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Вот это технологии!", for: .normal)
        button.backgroundColor = .YPBlack
        button.tintColor = .YPWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        return pageControl
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Private Methods:
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            wowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            wowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -84)
        ])
    }
    
    
    
}
// MARK: - Extensions:
