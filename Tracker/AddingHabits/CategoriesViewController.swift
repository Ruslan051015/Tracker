import Foundation
import UIKit

final class CategoriesViewController: UIViewController {
    // MARK: - Properties:
    var categories: [String] = ["Study", "Work", "Relax"]
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text      = "Категория"
        label.font      = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить категорию", for: .normal)
        button.tintColor           = .YPWhite
        button.frame.size          = CGSize(width: 335, height: 60)
        button.layer.masksToBounds = true
        button.layer.cornerRadius  = 16
        button.backgroundColor = .YPBlack
        //button.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
       let table = UITableView()
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 16
        table.separatorStyle = .singleLine
        table.backgroundColor = .YPBackground
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return table
    }()
    
    private lazy var backImageView: UIImageView = {
        let image       = UIImage(named: "StarLight")
        let imageView   = UIImageView(image: image)
        
        return imageView
    }()
    
    private lazy var backgroundLabel: UILabel = {
        let label = UILabel()
        label.text      = "Привычки и события можно\nобъединить по смыслу"
        label.font      = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        configureScreenItems()
        showOrHideBackground()
        
        tableView.delegate                  = self
        tableView.dataSource                = self
        tableView.allowsMultipleSelection   = false
        
    }
    
    // MARK: - Methods:
    private func configureScreenItems() {
        topTitle.translatesAutoresizingMaskIntoConstraints          = false
        tableView.translatesAutoresizingMaskIntoConstraints         = false
        addButton.translatesAutoresizingMaskIntoConstraints         = false
        backImageView.translatesAutoresizingMaskIntoConstraints     = false
        backgroundLabel.translatesAutoresizingMaskIntoConstraints   = false
        
        view.addSubview(topTitle)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(backImageView)
        view.addSubview(backgroundLabel)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            
            tableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            backImageView.heightAnchor.constraint(equalToConstant: 80),
            backImageView.widthAnchor.constraint(equalToConstant: 80),
            backImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -386),
            
            backgroundLabel.topAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 8),
            backgroundLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backgroundLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            backgroundLabel.heightAnchor.constraint(equalToConstant: 36),
            
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
        ])
    }
    // MARK: - Private methods:
    private func showOrHideBackground() {
        if !categories.isEmpty {
            backgroundLabel.isHidden = true
            backImageView.isHidden = true
        } else {
            backgroundLabel.isHidden = false
            backImageView.isHidden = false
        }
    }
}
// MARK: - UITableViewDataSource:
extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.backgroundColor = .clear
        if indexPath.row == categories.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell")
        return cell
    }
}

// MARK: - UITableViewDelegate:
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}
