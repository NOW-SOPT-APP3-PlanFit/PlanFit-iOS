//
//  BodyConditionSheetViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/21/24.
//

import UIKit

import SnapKit

protocol BodyConditionSheetViewDelegate: AnyObject {
    func dataBind(condition userChoice: BodyConditionModel)
}

final class BodyConditionSheetViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    private let exitButton = UIButton()
    
    private lazy var conditionListView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    // MARK: - Property
    
    private weak var delegate: BodyConditionSheetViewDelegate?
    
    private var userChoice: BodyConditionModel
    
    private let conditionKind = BodyConditionModel.allCases
    
    // MARK: - Initializer
    
    init(delegate: BodyConditionSheetViewDelegate?, choice: BodyConditionModel) {
        self.delegate = delegate
        self.userChoice = choice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setViewHierarchy()
        setAutoLayout()
        setDelegate()
    }
    
    // MARK: - Action
    
    @objc
    private func exitButtonDidTap(_ sender: UIButton) {
        delegate?.dataBind(condition: userChoice)
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension BodyConditionSheetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userChoice = conditionKind[indexPath.row]
        
        for i in 0..<collectionView.numberOfItems(inSection: indexPath.section) {
            guard i != indexPath.item else { continue }
            let otherIndexPath = IndexPath(item: i, section: indexPath.section)
            guard let cell = collectionView.cellForItem(at: otherIndexPath) as? BodyConditionCell else { continue }
            cell.isSelected = false
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BodyConditionSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditionKind.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BodyConditionCell.reuseIdentifier,
            for: indexPath
        ) as? BodyConditionCell else { return UICollectionViewCell() }
        
        let condition = conditionKind[indexPath.row]
        cell.dataBind(
            title: condition.title,
            description: condition.description,
            isCurrentChoice: condition == userChoice
        )
        return cell
    }
}

// MARK: - UISetting

private extension BodyConditionSheetViewController {
    func setUI() {
        view.backgroundColor = .gray06
        
        titleLabel.do {
            $0.setText("신체 컨디션", font: .head05, color: .gray01)
        }
        
        descriptionLabel.do {
            $0.setText(
                "오늘의 컨디션에 맞춰 운동 강도를 조절해드려요.",
                font: .body01,
                color: .gray02
            )
        }
        
        exitButton.do {
            $0.setImage(.delete, for: .normal)
            $0.tintColor = .gray01
            $0.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
        }
        
        conditionListView.do {
            $0.backgroundColor = .gray06
            $0.register(BodyConditionCell.self, forCellWithReuseIdentifier: BodyConditionCell.reuseIdentifier)
        }
    }
    
    func setViewHierarchy() {
        view.addSubviews(titleLabel, descriptionLabel, exitButton, conditionListView)
    }
    
    func setAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.equalToSuperview().offset(22)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-22)
            $0.width.height.equalTo(24)
        }
        
        conditionListView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout().with {
            $0.estimatedItemSize = CGSize(width: view.bounds.width - 44, height: 83)
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 10
        }
        return flowLayout
    }
    
    func setDelegate() {
        conditionListView.delegate = self
        conditionListView.dataSource = self
    }
}
