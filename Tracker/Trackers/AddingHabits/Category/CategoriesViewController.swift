import Foundation
import UIKit

final class CategoriesViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties:
    weak var delegate: CategoryViewControllerDelegate?
    var selectedCategory: String = ""
    
    // MARK: - Private properties:
    private let yandexMetrica = YandexMetrica.shared
    private var alertPresenter: AlertPresenterProtocol?
    private let viewModel: CategoryViewModel
    private let categoryStore = TrackerCategoryStore.shared
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = L10n.Localizable.Title.category
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.Localizable.Title.addCategory, for: .normal)
        button.tintColor = .YPWhite
        button.frame.size = CGSize(width: 335, height: 60)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
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
        table.separatorColor = .YPGrayGray
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.allowsMultipleSelection = false
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        
        return table
    }()
    
    private lazy var stubImageView: UIImageView = {
        let image = UIImage(named: "starLight")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Localizable.Title.emptyCategories
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - LifeCycle:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .YPWhite
        
        selectedCategory = delegate?.selectedCategory ?? ""
        alertPresenter = AlertPresenter(delegate: self)
        configureScreenItems()
        showOrHideEmptyLabels()
        
        viewModel.onChange = { [weak self] in
            guard let self else { return }
            self.showOrHideEmptyLabels()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Methods:
    init() {
        viewModel = CategoryViewModel()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScreenItems() {
        view.addSubview(topTitle)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(stubImageView)
        view.addSubview(stubLabel)
                
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            
            tableView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            stubImageView.heightAnchor.constraint(equalToConstant: 80),
            stubImageView.widthAnchor.constraint(equalToConstant: 80),
            stubImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stubImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -386),
            
            stubLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8),
            stubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stubLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stubLabel.heightAnchor.constraint(equalToConstant: 36),
            
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    // MARK: - Private methods:
    private func showOrHideEmptyLabels() {
        if !viewModel.categories.isEmpty {
            stubLabel.isHidden = true
            stubImageView.isHidden = true
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
            stubLabel.isHidden = false
            stubImageView.isHidden = false
        }
    }
    
    private func dismissCategoryViewController() {
        self.dismiss(animated: true)
    }
    
    private func showDeleteAlert(for category: String) {
        let alertModel = AlertModel(title: L10n.Localizable.Title.alertTitle, message: L10n.Localizable.Title.alertMessage, firstButtonText: L10n.Localizable.Button.delete, secondButtonText: L10n.Localizable.Button.cancel) { [weak self] in
            guard let self = self else { return }
            viewModel.deleteCategory(category)
        }
        alertPresenter?.showAlert(model: alertModel)
    }
    
    // MARK: - Objc-Methods:
    @objc private func addButtonTapped() {
        let viewToPresent = NewCategoryViewController(eventType: .creating)
        self.present(viewToPresent, animated: true)
    }
}

// MARK: - UITableViewDataSource:
extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let categoryName = viewModel.categories[indexPath.row].name
        let checkMarkStatus = selectedCategory != categoryName
        cell.selectionStyle = .none
        cell.layer.masksToBounds = true
        if viewModel.categories.count == 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        } else if indexPath.row == viewModel.categories.count - 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.layer.cornerRadius = 0
        }
        cell.configureCell(categoryName: categoryName, checkmarkStatus: checkMarkStatus)
        
        return cell
    }
}

// MARK: - UITableViewDelegate:
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else {
            return
        }
        
        let isHidden = false
        cell.setCheckMark(isHiden: isHidden)
        selectedCategory = cell.getCellTextLabelText()
        
        delegate?.selectedCategory = selectedCategory
        delegate?.showSelectedCategory()
        dismissCategoryViewController()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else {
            return
        }
        
        let isHidden = false
        cell.setCheckMark(isHiden: isHidden)
        selectedCategory = ""
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
            guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else {
                return UIMenu()
            }
            let editAction = UIAction(title: L10n.Localizable.Button.editTitle) { [weak self] action in
                guard let self = self else { return }
                yandexMetrica.sendReport(about: Analytics.Events.click, and: Analytics.Items.edit, on: Analytics.Screens.category)
                let editingCategoryName = cell.getCellTextLabelText()
                let viewToPresent = NewCategoryViewController(eventType: .editing)
                viewToPresent.editingCategoryName = editingCategoryName
                self.present(viewToPresent, animated: true)
            }
            
            let deleteAction = UIAction(title: L10n.Localizable.Button.delete, attributes: .destructive) { [weak self] action in
                guard let self = self else { return }
                yandexMetrica.sendReport(about: Analytics.Events.click, and: Analytics.Items.delete, on: Analytics.Screens.category)
                let categoryToDelete = cell.getCellTextLabelText()
                self.showDeleteAlert(for: categoryToDelete)
            }
            
            return UIMenu(children: [editAction, deleteAction])
        }
        return configuration
    }
}

