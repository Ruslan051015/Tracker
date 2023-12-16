import UIKit

class OnboardingViewController: UIPageViewController {
    // MARK: - Properties:
    
    
    // MARK: - Private Properties:
    private lazy var pages: [UIViewController] = {
        let firstPage = FirstPageViewController()
        let secondPage = SecondPageViewController()
        
        return [firstPage, secondPage]
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    
    
    // MARK: - Private Methods:
    
    
    
    
}
// MARK: - Extensions:
