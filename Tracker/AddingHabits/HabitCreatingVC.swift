import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: scroll.frame.width, height: scroll.frame.height + 200)
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
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.allowsSelection = true
        collection.allowsMultipleSelection = true
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    private let emojies: [String] = ["🙂", "😻", "🌺", "🐶", "❤️", "😱",
                                     "😇", "😡", "🥶", "🤔", "🙌", "🍔",
                                     "🥦", "🏓", "🥇", "🎸", "🏝️", "😪"]
    private let colors: [UIColor] = [
        .YPColorSelection1, .YPColorSelection2, .YPColorSelection3,
        .YPColorSelection4, .YPColorSelection5, .YPColorSelection6,
        .YPColorSelection7, .YPColorSelection8, .YPColorSelection9,
        .YPColorSelection10, .YPColorSelection11, .YPColorSelection12,
        .YPColorSelection13, .YPColorSelection14, .YPColorSelection15,
        .YPColorSelection16, .YPColorSelection17, .YPColorSelection18
    ]
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection          = true
        collectionView.allowsMultipleSelection  = false
        
        setupToHideKeyboardOnTapOnView()
        configureTitleAndScroll()
        
        configureSupplementaryView()
        
    }
    
    // MARK: - Private methods:
    private func configureTitleAndScroll() {
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topTitle)
        view.addSubview(scrollView)
        view.addSubview(stackView)
        
        scrollView.addSubview(textField)
        scrollView.addSubview(categoryButton)
        scrollView.addSubview(scheduleButton)
        scrollView.addSubview(dividerLine)
        scrollView.addSubview(collectionView)
        
        categoryButton.addSubview(chevronImage1)
        scheduleButton.addSubview(chevronImage2)
        
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.reuseIdentifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SupplementaryView.reuseIdentifier)
        
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
            
            collectionView.topAnchor.constraint(equalTo: scheduleButton.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 782),
            
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
        self.present(CategoriesVC(), animated: true)
    }
    
    private func configureSupplementaryView() {
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SupplementaryView.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension HabitCreatingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case sections.emojiCell.rawValue:
            return CGSize(width: collectionView.bounds.width / 7, height: 52)
        case sections.colorCell.rawValue:
            return CGSize(width: collectionView.bounds.width / 7, height: 52)
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case sections.emojiCell.rawValue:
            return 5
        case sections.colorCell.rawValue:
            return 5
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case sections.emojiCell.rawValue:
            return 0
        case sections.colorCell.rawValue:
            return 0
        default: return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case sections.emojiCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 50)
        case sections.colorCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 34)
            
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case sections.emojiCell.rawValue:
            return UIEdgeInsets(top: 24, left: 2, bottom: 24, right: 2)
        case sections.colorCell.rawValue:
            return UIEdgeInsets(top: 24, left: 2, bottom: 24, right: 2)
        default:
            return UIEdgeInsets()
        }
    }
    
    
}

// MARK: - UITableViewDataSource:
extension HabitCreatingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case sections.emojiCell.rawValue: return emojies.count
        case sections.colorCell.rawValue: return colors.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case sections.emojiCell.rawValue:
            guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
                print("Couldn't create emojiCell")
                return UICollectionViewCell()
            }
            emojiCell.emojiLabel.text = emojies[indexPath.row]
            emojiCell.emojiLabel.font = .systemFont(ofSize: 32)
            return emojiCell
            
        case sections.colorCell.rawValue:
            guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
                print("Couldn't create colorCell")
                return UICollectionViewCell()
            }
            colorCell.colorView.backgroundColor = colors[indexPath.row]
            return colorCell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SupplementaryView.reuseIdentifier, for: indexPath) as? SupplementaryView else { return UICollectionReusableView() }
        switch indexPath.section {
        case sections.emojiCell.rawValue:
            supplementaryView.titleLabel.text = "Emoji"
            return supplementaryView
            
        case sections.colorCell.rawValue:
            supplementaryView.titleLabel.text = "Цвет"
            return supplementaryView
            
        default:
            return UICollectionReusableView()
        }
    }
    
}

// MARK: - UICollectionViewDelegate:
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = collectionView.cellForItem(at: indexPath) as? ButtonsCell
        let emojiCell = collectionView.cellForItem(at: indexPath) as? EmojiCell
        let colorCell = collectionView.cellForItem(at: indexPath) as? ColorCell
        
        switch indexPath.section {
        case sections.emojiCell.rawValue:
            emojiCell?.layer.masksToBounds = true
            emojiCell?.layer.cornerRadius = 16
            emojiCell?.layer.backgroundColor = UIColor.YPLightGray.cgColor
            
        case sections.colorCell.rawValue:
            colorCell?.layer.masksToBounds = true
            colorCell?.layer.borderWidth = 2
            colorCell?.layer.borderColor = colorCell?.colorView.backgroundColor?.cgColor
        default:
            break
        }
    }
}


