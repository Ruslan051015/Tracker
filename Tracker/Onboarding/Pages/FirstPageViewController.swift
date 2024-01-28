import UIKit

final class FirstPageViewController: UIViewController {
    // MARK: - Private Properties:
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "firstScreen")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var praktikumLogoView: UIImageView = {
        let logo = UIImage(named: "praktikumLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Localizable.Title.firstPage
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .YPOnlyWhite
        self.view.addSubview(label)
        
        return label
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
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            praktikumLogoView.widthAnchor.constraint(equalToConstant: 94),
            praktikumLogoView.heightAnchor.constraint(equalToConstant: 94),
            praktikumLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            praktikumLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: praktikumLogoView.bottomAnchor, constant: 10)
            
        ])
    }
}

