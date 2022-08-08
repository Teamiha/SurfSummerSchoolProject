//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let cellHeight: CGFloat = 460
    }
    
    //MARK: - Private Property
    
    private let model: MainModel = .init()
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configurateModel()
        model.getPosts()
        configureNavigationBar()

        
    }

}

// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(FavoriteCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FavoriteCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configurateModel() {
        model.didItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
        
        let searchButton = UIBarButtonItem(
            image: UIImage(named: "searchButton"),
            style: .plain,
            target: self,
            action: #selector(moveToSearch)
            )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func moveToSearch() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}

// MARK: - UICollection

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.text = item.content
            cell.date = item.dateCreation
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.image = item.image
            cell.didFavoritesTapped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
