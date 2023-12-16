import UIKit

class FirstPageViewController: UIViewController {
    // MARK: - Private Properties:
    private let image = UIImage(named: "firstScreen")
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        return imageView
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Methods:
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    
    
}
// MARK: - Extensions:
