import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private let titlesForRows: [String] = ["Категория", "Расписание"]
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private var tableView = UITableView()
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        view.backgroundColor = .YPWhite
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureScreenItems()
    }
    
    // MARK: - Private methods:
    private func configureScreenItems() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTitle)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(FieldTableViewCell.self, forCellReuseIdentifier: FieldTableViewCell.reuseIdentifier)
        tableView.register(SecondSectionCell.self, forCellReuseIdentifier: SecondSectionCell.reuseIdentifier)
        
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            tableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}

// MARK: - UITableViewDelegate:
extension HabitCreatingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        24
    }
}

// MARK: - UITbaleViewDataSource:
extension HabitCreatingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if section == 0 {
            numberOfRows = 1
        } else {
            if section == 1 {
                numberOfRows = 2
            }
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier) as? FieldTableViewCell else {
            print("Не удалось создать текстовую ячейку")
            return UITableViewCell()
        }
        
        guard let settingsCell = tableView.dequeueReusableCell(withIdentifier: SecondSectionCell.reuseIdentifier) as? SecondSectionCell else {
            print("Не удалось создать ячейку с настройками")
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            return textFieldCell
        } else {
            if indexPath.section == 1 {
                settingsCell.label.text = titlesForRows[indexPath.row]
                return settingsCell
            }
        }
        
        return UITableViewCell()
    }
    
    
}
