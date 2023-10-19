//
//  TrackerCell.swift
//  Tracker
//
//  Created by Руслан Халилулин on 20.10.2023.
//

import UIKit

class TrackerCell: UICollectionViewCell {
    // MARK: - Properties:
    static let reuseID = "TrackersCell"
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .YPBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .YPBackground
        label.font = .systemFont(ofSize: 22)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 68
        label.text = "🎲"
        
        return label
    }()
    
    lazy var trackerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Learn swift"
        label.textColor = .YPWhite
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var daysCounterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .YPBlack
        label.text = "1 day"
        
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.tintColor = .YPWhite
        button.imageEdgeInsets = UIEdgeInsets(top: 11.72, left: 11.72, bottom: 12.07, right: 11.65)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17
        button.backgroundColor = topView.backgroundColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods:
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods:
    @objc private func plusButtonTapped() {
        let plusImage = UIImage(named: "Plus")
        let doneImage = UIImage(named: "Checkmark")
    
        if plusButton.currentImage != doneImage {
            plusButton.setImage(doneImage, for: .normal)
            plusButton.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
            plusButton.tintColor = .YPWhite
        } else {
            plusButton.setImage(UIImage(named: "Plus"), for: .normal)
            plusButton.imageEdgeInsets = UIEdgeInsets(top: 11.72, left: 11.72, bottom: 12.07, right: 11.65)
            plusButton.tintColor = .YPWhite
        }
    }
    
    private func configureCell() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        daysCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
        topView.addSubview(emojiLabel)
        topView.addSubview(trackerNameLabel)
        bottomView.addSubview(daysCounterLabel)
        bottomView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            //            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            //            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topView.widthAnchor.constraint(equalToConstant: 167),
            topView.heightAnchor.constraint(equalToConstant: 90),
            emojiLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 12),
            emojiLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            trackerNameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 44),
            trackerNameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -12),
            trackerNameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            trackerNameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -12),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: 167),
            bottomView.heightAnchor.constraint(equalToConstant: 58),
            daysCounterLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            daysCounterLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12),
            daysCounterLabel.widthAnchor.constraint(equalToConstant: 101),
            daysCounterLabel.heightAnchor.constraint(equalToConstant: 18),
            
            plusButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
    }
}
