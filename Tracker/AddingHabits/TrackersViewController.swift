import Foundation
import UIKit

final class TrackersViewController: ViewController, UITextFieldDelegate {
    // MARK: - Properties:
    var currentData: Date = Date()
    lazy var searchField: UISearchTextField = {
        let field = UISearchTextField()
        field.delegate = self
        
        return field
    }()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .YPWhite
        
        setTabBarsBorder()
        screenItemsSetup()
        
    }
    // MARK: - Private methods:
    private func screenItemsSetup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private func setTabBarsBorder() {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        line.backgroundColor = .YPGray
        self.tabBarController?.tabBar.addSubview(line)
        self.tabBarController?.tabBar.clipsToBounds = true
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
