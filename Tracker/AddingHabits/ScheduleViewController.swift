import Foundation
import UIKit

final class ScheduleViewController: UIViewController {
    // MARK: - Properties:
    weak var delegate: ScheduleViewControllerDelegate?
    
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let dictToSort: [String: Int] = ["Понедельник": 0, "Вторник": 1,
                                             "Среда": 2, "Четверг": 3, "Пятница": 4,
                                             "Суббота": 5, "Воскресенье": 6]
    
    
    private var selectedDays: [String] = [] {
        didSet {
            selectedDays.sort { (dictToSort[$0] ?? 7) < (dictToSort[$1] ?? 7) }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .YPBackground
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .YPWhite
        button.frame.size = CGSize(width: 335, height: 60)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.backgroundColor = .YPBlack
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedDays = delegate?.selectedDays ?? []
        print(selectedDays)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .YPWhite
        configureScreenItems()
    }
    
    // MARK: - Private methods:
    private func configureScreenItems() {
        view.addSubview(topTitle)
        view.addSubview(tableView)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 97),
            
            tableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 525),
            
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    @objc private func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            selectedDays.append(Weekdays.allCases[sender.tag].rawValue)
            print(selectedDays)
        } else {
            selectedDays.removeAll { $0 == Weekdays.allCases[sender.tag].rawValue }
            print(selectedDays)
        }
    }
    
    @objc private func doneButtonTapped() {
        delegate?.selectedDays = selectedDays
        delegate?.showSelectedDays()
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate:
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: - UITableViewDataSource:
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Weekdays.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row
        switchView.onTintColor = .YPBlue
        switchView.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        cell.textLabel?.text = Weekdays.allCases[indexPath.row].rawValue
        cell.backgroundColor = .clear
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if indexPath.row == 6 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10000)
        }
        let item = Weekdays.allCases[indexPath.row].rawValue
        
        for day in selectedDays {
            if day == item {
                switchView.isOn = true
            }
        }
        return cell
    }
}
