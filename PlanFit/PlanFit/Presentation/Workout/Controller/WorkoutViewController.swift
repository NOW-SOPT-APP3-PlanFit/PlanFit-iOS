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
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    private let workoutImageData = WorkoutImageData.list
    
    private let setVolumeList = SetVolume.list
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        configureCollectionView()
    }
    
    // MARK: - NavigationBar Setting
    
    private func setNavigationBar() {
        let headphoneImage = UIImage(resource: .headphone).withRenderingMode(.alwaysOriginal)
        let ellipsisImage = UIImage(resource: .ellipsis).withRenderingMode(.alwaysOriginal)
        let headphoneItem = UIBarButtonItem(image: headphoneImage,
                                            style: .plain,
                                            target: self,
                                            action: nil
        )
        
        let ellipsisItem = UIBarButtonItem(image: ellipsisImage,
                                           style: .plain,
                                           target: self,
                                           action: nil
        )
        
        navigationItem.titleView = rootView.currentTimeView
        navigationItem.rightBarButtonItems = [ellipsisItem, headphoneItem]
        
        navigationBarColor()
    }
    
    private func navigationBarColor() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .gray08BG
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = .gray08BG
        }
    }
    
    // MARK: - CollectionView Setting
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: rootView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case let workoutImage as WorkoutImageData:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutImageCell.reuseIdentifier,
                                                                    for: indexPath) as? WorkoutImageCell
                else {
                    return UICollectionViewCell()
                }
                
                cell.dataBind(workoutImage)
                return cell
                
            case let setVolume as SetVolume:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutSetCell.reuseIdentifier,
                                                                    for: indexPath) as? WorkoutSetCell
                else {
                    return UICollectionViewCell()
                }
                
                cell.dataBind(setData: setVolume, setNum: indexPath.item)
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
        )
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionLayoutKind = Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                switch sectionLayoutKind {
                case .WorkOutImage:
                    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                           withReuseIdentifier: WorkoutImageHeader.reuseIdentifier,
                                                                                           for: indexPath)
                            as? WorkoutImageHeader
                    else {
                        return UICollectionReusableView()
                    }
                    return headerView
                    
                case .SetVolume:
                    return UICollectionReusableView()
                }
                
            case UICollectionView.elementKindSectionFooter:
                
                switch sectionLayoutKind {
                case .WorkOutImage:
                    guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                           withReuseIdentifier: WorkoutImageFooter.reuseIdentifier,
                                                                                           for: indexPath)
                            as? WorkoutImageFooter
                    else {
                        return UICollectionReusableView()
                    }
                    return footerView
                    
                default:
                    return UICollectionReusableView()
                }
            default:
                return UICollectionReusableView()
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.WorkOutImage, .SetVolume])
        snapshot.appendItems(workoutImageData, toSection: .WorkOutImage)
        snapshot.appendItems(setVolumeList, toSection: .SetVolume)
        dataSource.apply(snapshot)
        
        rootView.collectionView.collectionViewLayout = setLayout()
    }
    
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionLayoutKind {
            case .WorkOutImage:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(312))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 31, bottom: 0, trailing: 32)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(65))
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(20))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                         elementKind: UICollectionView.elementKindSectionHeader,
                                                                         alignment: .top)
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                         elementKind: UICollectionView.elementKindSectionFooter,
                                                                         alignment: .bottom)
                section.boundarySupplementaryItems = [header, footer]
                
                return section
                
            case .SetVolume:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(48))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                section.interGroupSpacing = 8
                
                return section
            }
        }
        return layout
    }
}
