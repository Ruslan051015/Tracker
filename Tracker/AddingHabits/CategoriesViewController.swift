import Foundation
import UIKit

final class CategoriesViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties:
    weak var delegate: CategoryViewControllerProtocol?
    var categories: [String] = ["Hobby"] {
        didSet {
            showOrHideBackground()
        }
    }
    var selectedCategory: String = "" {
        didSet {
            print("SCVC category \(selectedCategory) was added")
        }
    }
    
    // MARK: - Private properties:
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text      = "Категория"
        label.font      = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 16
        table.separatorStyle = .singleLine
        table.backgroundColor = .clear
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private lazy var backImageView: UIImageView = {
        let image = UIImage(named: "StarLight")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var backgroundLabel: UILabel = {
        let label = UILabel()
        label.text      = "Привычки и события можно\nобъединить по смыслу"
        label.font      = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    // MARK: - LifeCycle:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedCategory = delegate?.selectedCategory ?? ""
    }
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
        view.addSubview(topTitle)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(backImageView)
        view.addSubview(backgroundLabel)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
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
            tableView.isHidden = true
            backgroundLabel.isHidden = false
            backImageView.isHidden = false
        }
    }
    @objc private func addButtonTapped() {
        delegate?.selectedCategory = selectedCategory
        delegate?.showSelectedCategory()
        self.dismiss(animated: true)
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
        cell.backgroundColor = .YPBackground
        cell.selectionStyle = .none
        if categories.count == 1 || indexPath.row == categories.count - 1 {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        }
        if selectedCategory == cell.textLabel?.text {
            cell.accessoryView = UIImageView(image: UIImage(named: "CheckmarkBlue"))
        }

        return cell
    }
}

// MARK: - UITableViewDelegate:
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let checkmark = UIImage(named: "CheckmarkBlue")
        if cell?.accessoryView != .none {
            cell?.accessoryView = .none
            selectedCategory = ""
        } else {
            cell?.accessoryView = UIImageView(image: checkmark)
            cell?.accessoryView?.bounds = CGRect(x: 0, y: 0, width: 14.3, height: 14.2)
            selectedCategory = cell?.textLabel?.text ?? ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = .none
        selectedCategory = ""
    }
}
