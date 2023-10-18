import Foundation
import UIKit

final class HabitViewController: UIViewController {
    // MARK: - Private properties:
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: scroll.frame.width, height: scroll.frame.height)
        scroll.isMultipleTouchEnabled = true
        
        return scroll
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        
        return label
    }()
    
    private lazy var textField: CustomUITextField = {
        let field = CustomUITextField(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41), placeholder: "Введите название трекера")
        field.backgroundColor = .YPBackground
        field.textColor = .YPBlack
        
        return field
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Категория", for: .normal)
        button.tintColor = .YPBlack
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius  = 16
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        button.backgroundColor = .YPBackground
        button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)

        return button
    }()
    
    private lazy var dividerLine: UIView = {
        let divider = UIView()
        divider.backgroundColor = .YPGray
        
        return divider
    }()
    
    private lazy var chevronImage1: UIImageView = {
        let imageView = UIImageView()
        let chevron = #imageLiteral(resourceName: "Chevron")
        imageView.image = chevron
        
        return imageView
    }()
    
    private lazy var chevronImage2: UIImageView = {
        let imageView = UIImageView()
        let chevron = #imageLiteral(resourceName: "Chevron")
        imageView.image = chevron
        
        return imageView
    }()
    
    private lazy var scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Расписание", for: .normal)
        button.tintColor = .YPBlack
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius  = 16
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.backgroundColor = .YPBackground
        //button.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        return button
    }()
   
    private let stackView = UIStackView()
    
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
    
        setupToHideKeyboardOnTapOnView()
        configureScreenItems()
    }
    
    // MARK: - Private methods:
    private func configureScreenItems() {
        topTitle.translatesAutoresizingMaskIntoConstraints       = false
        scrollView.translatesAutoresizingMaskIntoConstraints     = false
        textField.translatesAutoresizingMaskIntoConstraints      = false
        stackView.translatesAutoresizingMaskIntoConstraints      = false
        cancelButton.translatesAutoresizingMaskIntoConstraints   = false
        createButton.translatesAutoresizingMaskIntoConstraints   = false
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        dividerLine.translatesAutoresizingMaskIntoConstraints    = false
        chevronImage1.translatesAutoresizingMaskIntoConstraints  = false
        chevronImage2.translatesAutoresizingMaskIntoConstraints  = false
        
        view.addSubview(topTitle)
        view.addSubview(scrollView)
        view.addSubview(stackView)
        
        scrollView.addSubview(textField)
        scrollView.addSubview(categoryButton)
        scrollView.addSubview(scheduleButton)
        scrollView.addSubview(dividerLine)
        
        categoryButton.addSubview(chevronImage1)
        scheduleButton.addSubview(chevronImage2)
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(createButton)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            scrollView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            
            textField.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            
            categoryButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            categoryButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
            
            chevronImage1.trailingAnchor.constraint(equalTo: categoryButton.trailingAnchor, constant: -24),
            chevronImage1.bottomAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: -31),
            chevronImage2.trailingAnchor.constraint(equalTo: scheduleButton.trailingAnchor, constant: -24),
            chevronImage2.bottomAnchor.constraint(equalTo: scheduleButton.bottomAnchor, constant: -31),
            
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.bottomAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            dividerLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            scheduleButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            scheduleButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            scheduleButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            scheduleButton.heightAnchor.constraint(equalToConstant: 75),
            
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 166),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
            createButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 161),
            createButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    private func showCategories() {
        self.present(CategoriesViewController(), animated: true)
    }
}


