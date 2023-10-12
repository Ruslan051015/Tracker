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
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
//        configureScreenItems()
    }
    /*
    // MARK: - Methods:
    private func configureScreenItems() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
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
     */
}
