import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private let titlesForRows: [String] = ["Категория", "Расписание"]
    private var textFieldTableView = UITableView()
    private var settingsTableView = UITableView()
    private let stackView = UIStackView()
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPRed
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.YPRed.cgColor
        
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cоздать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .YPWhite
        button.backgroundColor = .YPGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        view.backgroundColor = .YPWhite
        super.viewDidLoad()
        
        textFieldTableView.dataSource = self
        textFieldTableView.delegate = self
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        configureTitleAndTextFieldTableView()
        configureSettingsTableView()
        configureStackViewAndButtons()
    }
    
    // MARK: - Private methods:
    private func configureTitleAndTextFieldTableView() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTitle)
        
        textFieldTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldTableView)
        
        textFieldTableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.reuseIdentifier)
        
        textFieldTableView.isScrollEnabled = false
        textFieldTableView.backgroundColor = .YPBackground
        textFieldTableView.separatorStyle = .none
        textFieldTableView.layer.masksToBounds = true
        textFieldTableView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            textFieldTableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            textFieldTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textFieldTableView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func configureSettingsTableView() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsTableView)
        
        settingsTableView.register(SecondSectionCell.self, forCellReuseIdentifier: SecondSectionCell.reuseIdentifier)
        
        settingsTableView.isScrollEnabled = false
        settingsTableView.backgroundColor = .YPBackground
        settingsTableView.layer.masksToBounds = true
        settingsTableView.layer.cornerRadius = 16
        settingsTableView.separatorInset = UIEdgeInsets(top: 0, left: 15.95, bottom: 0, right: 15.95)
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: textFieldTableView.bottomAnchor, constant: 24),
            settingsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            settingsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            settingsTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureStackViewAndButtons() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(createButton)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
//            cancelButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            cancelButton.topAnchor.constraint(equalTo: stackView.topAnchor),
//            cancelButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 166),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
//            createButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
//            createButton.topAnchor.constraint(equalTo: stackView.topAnchor),
//            createButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 161),
            createButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - UITableViewDelegate:
extension HabitCreatingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
}

// MARK: - UITableViewDataSource:
extension HabitCreatingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if tableView == textFieldTableView {
            numberOfRows = 1
        } else if tableView == settingsTableView {
            numberOfRows = 2
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == textFieldTableView {
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.reuseIdentifier) as? TextFieldCell else {
                print("Не удалось создать текстовую ячейку")
                return UITableViewCell()
            }
            textFieldCell.backgroundColor = .clear
            
            return textFieldCell
        } else if tableView == settingsTableView {
            guard let settingsCell = tableView.dequeueReusableCell(withIdentifier: SecondSectionCell.reuseIdentifier) as? SecondSectionCell else {
                print("Не удалось создать ячейку с настройками")
                return UITableViewCell()
            }
            settingsCell.backgroundColor = .clear
            settingsCell.accessoryType = .disclosureIndicator
            settingsCell.label.text = titlesForRows[indexPath.row]
            return settingsCell
        }
        
        return UITableViewCell()
    }
}
