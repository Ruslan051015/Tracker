import Foundation
import UIKit

final class HabitOrEventViewController: UIViewController {
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = L10n.Localizable.Title.trackerCreating
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var newHabit: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .YPBlack
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Localizable.Title.habit, for: .normal)
        button.addTarget(self, action: #selector(openHabitViewController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var newEvent: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .YPBlack
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Localizable.Title.event, for: .normal)
        button.addTarget(self, action: #selector(openEventViewController), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        configureScreenItems()
    }
    
    // MARK: - Private methods:
    private func configureScreenItems() {
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
            
            newEvent.topAnchor.constraint(equalTo: newHabit.bottomAnchor, constant: 16),
            newEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newEvent.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Objc-Methods:
    @objc private func openHabitViewController() {
        let viewToPresent = TrackerCreatingViewController(trackerType: .habit)
        self.present(viewToPresent, animated: true)
    }
    
    @objc private func openEventViewController() {
        let viewToPresent = TrackerCreatingViewController(trackerType: .event)
        self.present(viewToPresent, animated: true)
    }
}

