import Foundation
import UIKit

final class ScheduleVC: UIViewController {
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
       let label = UILabel()
        label.text = "Расписание"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private enum WeekDays: String {
        case Monday     = "Понедельник"
        case Tuesday    = "Вторник"
        case Wednesday  = "Среда"
        case Thursday   = "Четверг"
        case Friday     = "Пятница"
        case Saturday   = "Суббота"
        case Sunday     = "Воскресенье"
    }
    
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.backgroundColor = .YPBackground
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 16
        
        return stack
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.tintColor           = .YPWhite
        button.frame.size          = CGSize(width: 335, height: 60)
        button.layer.masksToBounds = true
        button.layer.cornerRadius  = 16
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
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(topTitle)
        view.addSubview(stackView)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 97),
            
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -47),
            
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func configureStackView() {
        
    }
}
