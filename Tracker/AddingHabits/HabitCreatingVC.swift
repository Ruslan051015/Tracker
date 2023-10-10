import Foundation
import UIKit

final class HabitCreatingVC: UIViewController {
    // MARK: - Private properties:
    private let titlesForRows: [String] = ["Категория", "Расписание"]
    private let stackView = UIStackView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
    
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureTitleAndCollectionView()
        configureStackViewAndButtons()
    }
    
    // MARK: - Private methods:
    private func configureTitleAndCollectionView() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTitle)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(TextFieldCell.self, forCellWithReuseIdentifier: TextFieldCell.reuseIdentifier)
        collectionView.register(ButtonsCell.self, forCellWithReuseIdentifier: ButtonsCell.reuseIdentifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeader")
    
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            topTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topTitle.heightAnchor.constraint(equalToConstant: 22),
            topTitle.widthAnchor.constraint(equalToConstant: 149),
            
            collectionView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 38),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            
            cancelButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 166),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
            createButton.widthAnchor.constraint(equalToConstant: 161),
            createButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension HabitCreatingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case sections.textfieldCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 75)
        case sections.buttonsCell.rawValue:
            return CGSize(width: collectionView.bounds.width, height: 75)
            //        case sections.emojiCell.rawValue:
            //            return CGSize(width: collectionView.bounds.width / 6, height: 52)
            //        case sections.colorCell.rawValue:
            //            return CGSize(width: collectionView.bounds.width / 6, height: 52)
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case sections.textfieldCell.rawValue:
            return 0
        case sections.buttonsCell.rawValue:
            return 0
            //        case sections.emojiCell.rawValue:
            //            return 5
            //        case sections.colorCell.rawValue:
            //            return 5
        default: return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        
        case sections.buttonsCell.rawValue:
            return CGSize(width: 1, height: 24)
        default: return CGSize()
        }
    }
}

// MARK: - UITableViewDataSource:
extension HabitCreatingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case sections.textfieldCell.rawValue: return 1
        case sections.buttonsCell.rawValue: return 2
//        case sections.emojiCell.rawValue: return emojies.count
//        case sections.colorCell.rawValue: return colors.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case sections.textfieldCell.rawValue:
            guard let textFieldCell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.reuseIdentifier, for: indexPath) as? TextFieldCell else {
                print("Couldn't create textfieldCell")
                return UICollectionViewCell()
            }
            textFieldCell.backgroundColor = .YPBackground
            textFieldCell.textField.textColor = .YPBlack
            textFieldCell.layer.masksToBounds = true
            textFieldCell.layer.cornerRadius = 16
            return textFieldCell
        case sections.buttonsCell.rawValue:
            let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1))
            headerView?.backgroundColor = .YPBackground
            headerView?.layer.masksToBounds = true
            headerView?.layer.cornerRadius = 16
            guard let buttonsCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.reuseIdentifier, for: indexPath) as? ButtonsCell else {
                print("Couldn't create buttonsCell")
                return UICollectionViewCell()
            }
            if indexPath.row == 0 {
                buttonsCell.label.text = "Категория"
//                buttonsCell.contentView.inputAccessoryView =
                return buttonsCell
            } else if indexPath.row == 1 {
                buttonsCell.label.text = "Расписание"
                return buttonsCell
            }
            return buttonsCell
        /*case sections.emojiCell.rawValue:
            guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: indexPath) as? EmojiCell else {
                print("Couldn't create emojiCell")
                return UICollectionViewCell()
            }
         return emojiCell
        case sections.colorCell.rawValue:
            guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: indexPath) as? ColorCell else {
                print("Couldn't create colorCell")
                return UICollectionViewCell()
            }
         return colorCell
         */
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeader", for: indexPath)
            return headerView
    }
}
