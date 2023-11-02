import Foundation
import UIKit

protocol HabitOrEventDelegate: AnyObject {
    func addTracker(_ tracker: Tracker, and category: String, from: HabitOrEventViewController)
}

final class TrackersViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties:
    var currentDate: Date = Date()
    var categories: [TrackerCategory] = [] {
        didSet {
            print(categories)
        }
    }
    var visibleCategories: [TrackerCategory] = [] {
        didSet {
            showOrHideStubs()
        }
    }
    var completedTrackers: Set<TrackerRecord> = []
    
    // MARK: - Private properties:
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        picker.tintColor = .YPBlue
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 34).isActive = true
        picker.widthAnchor.constraint(equalToConstant: 110).isActive = true
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    private lazy var searchField: UISearchTextField = {
        let field = UISearchTextField()
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Поиск"
        field.backgroundColor = .clear
        
        return field
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TrackerCell.self, forCellWithReuseIdentifier: TrackerCell.reuseID)
        collection.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SupplementaryView.reuseId)
        
        return collection
    }()
    
    private lazy var stubImageView: UIImageView = {
        let image = UIImage(named: "StarLight")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .YPWhite
        screenItemsSetup()
        navBarSetup()
        showOrHideStubs()
    }
    
    // MARK: - Private methods:
    private func screenItemsSetup() {
        self.view.addSubview(searchField)
        self.view.addSubview(collectionView)
        self.view.addSubview(stubImageView)
        self.view.addSubview(stubLabel)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stubImageView.heightAnchor.constraint(equalToConstant: 80),
            stubImageView.widthAnchor.constraint(equalToConstant: 80),
            stubImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stubImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -330),
            
            stubLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8),
            stubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stubLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stubLabel.heightAnchor.constraint(equalToConstant: 18),
            
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func navBarSetup() {
        if let navigationBar = navigationController?.navigationBar {
            title = "Трекеры"
            navigationBar.prefersLargeTitles = true
            
            let rightButton = UIBarButtonItem(customView: datePicker)
            navigationItem.rightBarButtonItem = rightButton
            
            let leftButton = UIBarButtonItem(image: UIImage(named: "Plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
            leftButton.tintColor = .YPBlack
            navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    private func showOrHideStubs() {
        if !categories.isEmpty {
            stubLabel.isHidden = true
            stubImageView.isHidden = true
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
            stubLabel.isHidden = false
            stubImageView.isHidden = false
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Current date: \(formattedDate)")
    }
    
    @objc private func plusButtonTapped() {
        let viewToPresent = HabitOrEventViewController()
        viewToPresent.delegate = self
        self.present(viewToPresent, animated: true)
    }
}

// MARK: - UICollectionViewDelegate:
extension TrackersViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 167, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        let headerViewSize = headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                                       height: UIView.layoutFittingExpandedSize.height),
                                                                withHorizontalFittingPriority: .required,
                                                                verticalFittingPriority: .fittingSizeLevel)
        return headerViewSize
    }
}

// MARK: - UICollectionViewDataSource:
extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories[section].includedTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.reuseID, for: indexPath) as? TrackerCell else { return UICollectionViewCell()}
        let tracker = categories[indexPath.section].includedTrackers[indexPath.row]
        cell.cellConfig(
            id: tracker.id,
            name: tracker.name,
            color: .YPColorSelection1,
            emoji: "🛫",
            isCompleted: true,
            completedDays: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SupplementaryView.reuseId, for: indexPath) as! SupplementaryView
        headerView.titleLabel.text = categories[indexPath.section].name
        headerView.titleLabel.font = .boldSystemFont(ofSize: 19)
        
        return headerView
    }
}

// MARK: - HabitOrEventDelegate:
extension TrackersViewController: HabitOrEventDelegate {
    func addTracker(_ tracker: Tracker, and category: String, from: HabitOrEventViewController) {
        print("add tracker was called")
        let trackerArray = [tracker]
        let newCategory = TrackerCategory(name: category, includedTrackers: trackerArray)
        categories.append(newCategory)
        showOrHideStubs()
        collectionView.reloadData()
    }
}
