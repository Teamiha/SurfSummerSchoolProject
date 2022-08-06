//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    //MARK: - Private Property
    
    private let model: MainModel = .init()
    
    //MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configurateModel()
        model.getPosts()
        model.items[5].isFavorite = true
        
        // MARK: - NavigationController
        
        let searchButton = UIBarButtonItem(
            image: UIImage(named: "searchButton"),
            style: .plain,
            target: self,
            action: #selector(moveToSearch)
            )
        
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.title = "Главная"
    }

    
    @objc func moveToSearch() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

//MARK: - Private Methods

private extension MainViewController {
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configurateModel() {
        model.didItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.image = item.image
            cell.didFavoriteTaped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidh = (view.frame.width - Constants.horizontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidh, height: 1.46 * itemWidh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
