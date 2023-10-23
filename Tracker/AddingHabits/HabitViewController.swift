import Foundation
import UIKit

protocol ScheduleViewControllerProtocol: AnyObject {
    func showSelectedDays()
    var selectedDays: [String] { get set }
}

final class HabitViewController: UIViewController {
    // MARK: - Properties:
    var selectedDays: [String] = []
    // MARK: - Private properties:
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: scroll.frame.width, height: scroll.frame.height)
        scroll.isMultipleTouchEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var textField: CustomUITextField = {
        let field = CustomUITextField(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41), placeholder: "Введите название трекера")
        field.backgroundColor = .YPBackground
        field.textColor = .YPBlack
        field.translatesAutoresizingMaskIntoConstraints = false
        
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
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var dividerLine: UIView = {
        let divider = UIView()
        divider.backgroundColor = .YPGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
    
    private lazy var chevronImage1: UIImageView = {
        let imageView = UIImageView()
        let chevron = #imageLiteral(resourceName: "Chevron")
        imageView.image = chevron
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var chevronImage2: UIImageView = {
        let imageView = UIImageView()
        let chevron = #imageLiteral(resourceName: "Chevron")
        imageView.image = chevron
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        button.addTarget(self, action: #selector(showSchedule), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var selectedDaysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .YPGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
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
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        view.backgroundColor = .YPWhite
        super.viewDidLoad()
        
        setupToHideKeyboardOnTapOnView()
        configureScreenItems()
    }
    
    // MARK: - Methods:
    func hideScheduleButton() {
        scheduleButton.isHidden = true
        dividerLine.isHidden = true
    }
    // MARK: - Private methods:
    private func configureScreenItems() {
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
    
    @objc private func showCategories() {
        let viewToPresent = CategoriesViewController()
        self.present(viewToPresent, animated: true)
    }
    
    @objc private func showSchedule() {
        let viewToPresent = ScheduleViewController()
        viewToPresent.delegate = self
        self.present(viewToPresent, animated: true)
    }
}

// MARK: - Extension:
extension HabitViewController: ScheduleViewControllerProtocol {
    func showSelectedDays() {
        print("show selected days was called")
        if !selectedDays.isEmpty {
            scheduleButton.addSubview(selectedDaysLabel)
            scheduleButton.titleEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 38, right: 56)
            NSLayoutConstraint.activate([
                selectedDaysLabel.leadingAnchor.constraint(equalTo: scheduleButton.leadingAnchor, constant: 16),
                selectedDaysLabel.topAnchor.constraint(equalTo: scheduleButton.topAnchor, constant: 39),
                selectedDaysLabel.trailingAnchor.constraint(equalTo: scheduleButton.trailingAnchor, constant: -56),
                selectedDaysLabel.heightAnchor.constraint(equalToConstant: 22)
            ])
        } else {
            scheduleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        let weekDays: [String] = ["Понедельник","Вторник","Среда","Четверг","Пятница"]
        let weekEnd: [String] = ["Суббота", "Воскресенье"]
        let week: [String] = ["Понедельник","Вторник","Среда","Четверг","Пятница", "Суббота", "Воскресенье"]
        
        if weekDays.allSatisfy(selectedDays.contains(_:)) && weekDays.count == selectedDays.count {
            selectedDaysLabel.text = "Будни"
        } else if weekEnd.allSatisfy(selectedDays.contains(_:)) && weekEnd.count == selectedDays.count {
            selectedDaysLabel.text = "Выходные дни"
        } else if week.allSatisfy(selectedDays.contains(_:)) {
            selectedDaysLabel.text = "Все дни"
        } else {
            selectedDaysLabel.text = selectedDays.map { $0.shortName() }.joined(separator: ", ")
        }
    }
}

