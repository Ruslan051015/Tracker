import UIKit

class StatisticsViewController: UIViewController {
    // MARK: - Private properties:
    private var completedTrackersCount: Int? = 1 {
        didSet {
            showOrHideEmptyLabels()
        }
    }
    private lazy var stubLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        label.text = L10n.Localizable.Title.noDataToAnalyze
        label.textColor = .YPBlack
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stubImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "sadSmile")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var bestPeriodView: UIView = {
        let gradientView = UIView()
        gradientView.backgroundColor = .clear
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        gradientView.layer.borderWidth = 1
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    private lazy var idealDaysView: UIView = {
        let gradientView = UIView()
        gradientView.backgroundColor = .clear
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        gradientView.layer.borderWidth = 1
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    private lazy var completedTrackersView: UIView = {
        let gradientView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 343, height: 90)))
        gradientView.backgroundColor = .clear
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        gradientView.layer.borderWidth = 1
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    private lazy var averageValueView: UIView = {
        let gradientView = UIView()
        gradientView.backgroundColor = .clear
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        gradientView.layer.borderWidth = 1
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    // MARK: - LifeCycle:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        completedTrackersView.addGradientBorder(colors: [UIColor(hex: "#007BFA"), UIColor(hex: "#46E69D"), UIColor(hex: "#FD4C49")], width: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .YPWhite
        
        showOrHideEmptyLabels()
        setupNavBar()
        setupUI()
    }
    
    // MARK: - Private methods:
    private func setupUI() {
        self.view.addSubview(stubLabel)
        self.view.addSubview(stubImage)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(bestPeriodView)
        stackView.addArrangedSubview(idealDaysView)
        stackView.addArrangedSubview(completedTrackersView)
        stackView.addArrangedSubview(averageValueView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stubImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            stubImage.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            stubLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stubLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            stubLabel.topAnchor.constraint(equalTo: stubImage.bottomAnchor, constant: 8),
            
            bestPeriodView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bestPeriodView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            bestPeriodView.heightAnchor.constraint(equalToConstant: 90),
            idealDaysView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            idealDaysView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            idealDaysView.heightAnchor.constraint(equalToConstant: 90),
            completedTrackersView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            completedTrackersView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            completedTrackersView.heightAnchor.constraint(equalToConstant: 90),
            averageValueView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            averageValueView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            averageValueView.heightAnchor.constraint(equalToConstant: 90),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 206),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -210)
        ])
    }
    
    private func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            title = L10n.Localizable.Title.statistics
            navBar.prefersLargeTitles = true
        }
    }
    
    private func showOrHideEmptyLabels() {
        if completedTrackersCount == nil {
            stubImage.isHidden = false
            stubLabel.isHidden = false
            completedTrackersView.isHidden = true
        } else if completedTrackersCount != nil {
            stubImage.isHidden = true
            stubLabel.isHidden = true
            completedTrackersView.isHidden = false
        }
    }
}
