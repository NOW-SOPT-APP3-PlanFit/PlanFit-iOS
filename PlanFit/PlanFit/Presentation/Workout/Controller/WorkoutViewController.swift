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
    }
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: rootView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case let workoutImage as WorkoutImageData:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutImageCell.reuseIdentifier,
                                                                    for: indexPath) as? WorkoutImageCell
                else {
                    return nil
                }
                
                cell.dataBind(workoutImage)
                return cell
            default:
                return nil
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
                
                return section
            }
        }
        return layout
    }
}
