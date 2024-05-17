//
//  WorkoutViewController.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    // MARK: - CollectionView Section
    
    enum Section: Int {
        case WorkOutImage, SetVolume
    }
    
    // MARK: - Propertity
    
    private let rootView = WorkoutView()
    
    private let stopwatchView = StopwatchView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    private let workoutImageData = WorkoutImageData.list
    
    private var setVolumeList = SetVolume.list
    
    private var currentSet = IndexPath(item: 0, section: 1)
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        configureCollectionView()
        setCompleteSetBtn()
    }
    
    // MARK: - NavigationBar Setting
    
    private func setNavigationBar() {
        let headphoneImage = UIImage(resource: .headphone).withRenderingMode(.alwaysOriginal)
        let ellipsisImage = UIImage(resource: .ellipsis).withRenderingMode(.alwaysOriginal)
        let headphoneItem = UIBarButtonItem(image: headphoneImage, style: .plain, target: self, action: nil)
        let ellipsisItem = UIBarButtonItem(image: ellipsisImage, style: .plain, target: self, action: nil)
        
        navigationItem.titleView = stopwatchView
        navigationItem.rightBarButtonItems = [ellipsisItem, headphoneItem]
        
        navigationBarColor()
    }
    
    private func navigationBarColor() {
        let appearance = UINavigationBarAppearance()
        let navigationBar = navigationController?.navigationBar
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray08BG
        navigationBar?.standardAppearance = appearance
        navigationBar?.scrollEdgeAppearance = navigationBar?.standardAppearance
    }
    
    // MARK: - CollectionView Setting
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: rootView.collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case let workoutImage as WorkoutImageData:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: WorkoutImageCell.reuseIdentifier,
                        for: indexPath
                    ) as? WorkoutImageCell else {
                        return UICollectionViewCell()
                    }
                    
                    cell.dataBind(workoutImage)
                    return cell
                    
                case let setVolume as SetVolume:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: WorkoutSetCell.reuseIdentifier,
                        for: indexPath
                    ) as? WorkoutSetCell else {
                        return UICollectionViewCell()
                    }
                    
                    cell.dataBind(setData: setVolume, setNum: indexPath.item)
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            }
        )
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            guard let self,
                  let sectionLayoutKind = Section(rawValue: indexPath.section)
            else {
                return nil
            }
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard sectionLayoutKind == .WorkOutImage,
                      let headerView = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: WorkoutImageHeader.reuseIdentifier,
                        for: indexPath
                      ) as? WorkoutImageHeader
                else {
                    return nil
                }
                return headerView
                
            case UICollectionView.elementKindSectionFooter:
                return configureFooterView(
                    sectionKind: sectionLayoutKind,
                    collectionView: collectionView,
                    kind: kind,
                    indexPath: indexPath
                )
                
            default:
                return nil
            }
        }
        
        rootView.collectionView.collectionViewLayout = setLayout()
        applySectionItems()
    }
    
    private func configureFooterView(
        sectionKind: Section,
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch sectionKind {
        case .WorkOutImage:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WorkoutImageFooter.reuseIdentifier,
                for: indexPath
            ) as? WorkoutImageFooter else {
                return UICollectionReusableView()
            }
            return footerView
            
        case .SetVolume:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WorkoutSetFooter.reuseIdentifier,
                for: indexPath
            ) as? WorkoutSetFooter else {
                return UICollectionReusableView()
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addSetDidtap))
            footerView.addSetStackView.addGestureRecognizer(tapGestureRecognizer)
            
            return footerView
        }
    }
    
    private func applySectionItems() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.WorkOutImage, .SetVolume])
        snapshot.appendItems(workoutImageData, toSection: .WorkOutImage)
        snapshot.appendItems(setVolumeList, toSection: .SetVolume)
        dataSource.apply(snapshot)
    }
    
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionLayoutKind {
            case .WorkOutImage:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(312)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 31, bottom: 0, trailing: 32)
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(65)
                )
                let footerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(20)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [header, footer]
                
                return section
                
            case .SetVolume:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(48)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
                section.interGroupSpacing = 8
                
                let footerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(165)
                )
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [footer]
                
                return section
            }
        }
        return layout
    }
    
    // MARK: - Action
    
    @objc
    private func addSetDidtap() {
        guard setVolumeList.count < 30 else { return }
        
        if setVolumeList.last?.completedSet == true {
            let setVolume = SetVolume(weight: 8, repsNum: 15, currentSet: true, completedSet: false)
            setVolumeList.append(setVolume)
            setCompletedSetNum(setVolumeList.count)
        } else {
            let setVolume = SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false)
            setVolumeList.append(setVolume)
        }
        applySectionItems()
    }
    
    private func setCompleteSetBtn() {
        rootView.completeSetButton.addTarget(self, action: #selector(completeSetBtnDidtap), for: .touchUpInside)
    }
    
    @objc
    private func completeSetBtnDidtap() {
        guard currentSet.item < setVolumeList.count else { return }
        
        guard let currentCell = rootView.collectionView.cellForItem(at: currentSet) as? WorkoutSetCell else { return }
        setVolumeList[currentSet.item].completedSet = true
        setVolumeList[currentSet.item].currentSet = false
        currentCell.completedSetAttributes()
        setCompletedSetNum(currentSet.item + 2)
        
        currentSet.item += 1
        guard let nextCell = rootView.collectionView.cellForItem(at: currentSet) as? WorkoutSetCell
        else {
            setCompletedSetNum(nil)
            return
        }
        setVolumeList[currentSet.item].currentSet = true
        nextCell.currentSetAttributes()
        
        applySectionItems()
    }
    
    private func setCompletedSetNum(_ completedSet: Int?) {
        guard let completedSet = completedSet 
        else {
            rootView.completeSetButton.setTitle(
                "세트 완료",
                font: .subtitle01,
                titleColor: .gray10
            )
            return
        }
        rootView.completeSetButton.setTitle(
            "\(completedSet) 세트 완료",
            font: .subtitle01,
            titleColor: .gray10
        )
    }
}
