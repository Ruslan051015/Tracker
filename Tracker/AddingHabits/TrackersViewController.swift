import Foundation
import UIKit

protocol TrackersViewControllerProtocol: AnyObject {
    func addCategory(_ name: TrackerCategory)
}

final class TrackersViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties:
    var currentDate: Date = Date()
    var categories: [TrackerCategory] = [] {
        didSet {
            print(categories)
        }
    }
    var visibleCategories: [TrackerCategory] = []
    var completedTrackers: Set<TrackerRecord> = []
    
    // MARK: - Private properties:
    private let datePicker: UIDatePicker = {
        let picker                                                   = UIDatePicker()
        picker.preferredDatePickerStyle                              = .compact
        picker.datePickerMode                                        = .date
        picker.tintColor                                             = .YPBlue
        picker.translatesAutoresizingMaskIntoConstraints             = false
        picker.heightAnchor.constraint(equalToConstant: 34).isActive = true
        picker.widthAnchor.constraint(equalToConstant: 110).isActive = true
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    private lazy var searchField: UISearchTextField = {
        let field = UISearchTextField()
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
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
    }
    
    // MARK: - Private methods:
    private func screenItemsSetup() {
        view.addSubview(searchField)
        view.addSubview(collectionView)
        
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: TrackerCell.reuseID)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
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
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate         = sender.date
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        let formattedDate        = dateFormatter.string(from: selectedDate)
        print("Current date: \(formattedDate)")
    }
    
    @objc private func plusButtonTapped() {
        let viewToPresent = HabitOrEventViewController()
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
}

// MARK: - UICollectionViewDataSource:
extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.reuseID, for: indexPath) as? TrackerCell else { return UICollectionViewCell()}
        
        return cell
    }
}

// MARK: - TrackersViewControllerProtocol:
extension TrackersViewController: TrackersViewControllerProtocol {
    func addCategory(_ name: TrackerCategory) {
        categories.append(name)
    }
}
