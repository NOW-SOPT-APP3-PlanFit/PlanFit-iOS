//
//  WorkoutTimeSheetViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/21/24.
//

import UIKit

import SnapKit

protocol WorkoutTimeSheetViewDelegate: AnyObject {
    func dataBind(time userChoice: WorkoutTimeModel)
}

final class WorkoutTimeSheetViewController: UIViewController {
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    private let exitButton = UIButton()
    
    private lazy var timeListView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    // MARK: - Property
    
    private weak var delegate: WorkoutTimeSheetViewDelegate?
    
    private var userChoice: WorkoutTimeModel
    
    private let timeKind = WorkoutTimeModel.allCases
    
    // MARK: - Initializer

    init(delegate: WorkoutTimeSheetViewDelegate, choice: WorkoutTimeModel) {
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
        delegate?.dataBind(time: userChoice)
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension WorkoutTimeSheetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userChoice = timeKind[indexPath.row]
        
        for i in 0..<collectionView.numberOfItems(inSection: indexPath.section) {
            guard i != indexPath.item else { continue }
            let otherIndexPath = IndexPath(item: i, section: indexPath.section)
            guard let cell = collectionView.cellForItem(at: otherIndexPath) as? WorkoutTimeCell else { continue }
            cell.isSelected = false
        }
    }
}

// MARK: - UICollectionViewDataSource

extension WorkoutTimeSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeKind.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkoutTimeCell.reuseIdentifier,
            for: indexPath
        ) as? WorkoutTimeCell else { return UICollectionViewCell() }
        
        let time = timeKind[indexPath.row]
        cell.dataBind(
            title: time.title,
            description: time.description,
            isCurrentChoice: time == userChoice
        )
        return cell
    }
}

// MARK: - UISetting

private extension WorkoutTimeSheetViewController {
    func setUI() {
        view.backgroundColor = .gray06
        
        titleLabel.do {
            $0.setText("운동 시간", font: .head05, color: .gray01)
        }
        
        descriptionLabel.do {
            $0.setText(
                "선택한 시간에 맞게 운동량을 조절해드려요.",
                font: .body01,
                color: .gray02
            )
        }
        
        exitButton.do {
            $0.setImage(.delete, for: .normal)
            $0.tintColor = .gray01
            $0.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
        }
        
        timeListView.do {
            $0.backgroundColor = .gray06
            $0.register(WorkoutTimeCell.self, forCellWithReuseIdentifier: WorkoutTimeCell.reuseIdentifier)
        }
    }
    
    func setViewHierarchy() {
        view.addSubviews(titleLabel, descriptionLabel, exitButton, timeListView)
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
        
        timeListView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout().with {
            $0.estimatedItemSize = CGSize(width: view.bounds.width - 44, height: 60)
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 10
        }
        return flowLayout
    }
    
    func setDelegate() {
        timeListView.delegate = self
        timeListView.dataSource = self
    }
}
