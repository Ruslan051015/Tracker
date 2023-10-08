import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private var textFieldTableView = UITableView()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        view.backgroundColor = .YPWhite
        super.viewDidLoad()
        
        textFieldTableView.dataSource = self
        textFieldTableView.delegate = self
        
        configureScreenItems()
    }
    
    // MARK: - Private methods:
    private func configureScreenItems() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTitle)
        
        textFieldTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldTableView)
        
        textFieldTableView.register(FieldTableViewCell.self, forCellReuseIdentifier: FieldTableViewCell.reuseIdentifier)
        
        textFieldTableView.separatorStyle = .none
        
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
}
extension HabitCreatingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension HabitCreatingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier, for: indexPath)
        guard let textFieldCell = cell as? FieldTableViewCell else {
            print("Не удалось создать текстовую ячейку")
            return UITableViewCell()}
        return cell
    }
    
    
}
