import UIKit

class StatisticsViewController: UIViewController {
    // MARK: - Private properties:
    private lazy var stubLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        label.text = "Анализировать пока нечего"
        label.textColor = .YPBlack
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stubImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "SadSmile")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .YPWhite
        setupNavBar()
        setupStubs()
    }
    
    // MARK: - Private methods:
    private func setupStubs() {
        self.view.addSubview(stubLabel)
        self.view.addSubview(stubImage)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stubLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stubLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            stubLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -247),
            stubImage.centerXAnchor.constraint(equalTo: stubLabel.centerXAnchor),
            stubImage.bottomAnchor.constraint(equalTo: stubLabel.topAnchor, constant: -8)
        ])
    }
    
    private func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            title = "Статистика"
            navBar.prefersLargeTitles = true
        }
    }
}
