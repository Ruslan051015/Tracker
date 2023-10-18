import Foundation
import UIKit

final class CreatingViewController: UIViewController {
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
       let label = UILabel()
        label.text = "Cоздание трекера"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private lazy var newHabit: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Привычка", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .YPBlack
        //button.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var newEvent: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нерегулярное событие", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .YPBlack
        //button.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        configureScreenItems()
    }
    // MARK: - Methods:
    private func configureScreenItems() {
        newHabit.translatesAutoresizingMaskIntoConstraints = false
        newEvent.translatesAutoresizingMaskIntoConstraints = false
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(newHabit)
        view.addSubview(newEvent)
        view.addSubview(topTitle)
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            newHabit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newHabit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newHabit.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 295),
            newHabit.heightAnchor.constraint(equalToConstant: 60),
            newHabit.widthAnchor.constraint(equalToConstant: 335),
            
            newEvent.topAnchor.constraint(equalTo: newHabit.bottomAnchor, constant: 16),
            newEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newEvent.heightAnchor.constraint(equalToConstant: 60),
            newEvent.widthAnchor.constraint(equalToConstant: 335)
        ])
    }
}
