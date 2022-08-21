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
    
    private var model: MainModel = .init()
    private var filteredElements: [DetailItemModel] = []
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configurateModel()
        model.loadPosts()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.loadPosts()
        filteredElements = filteredModel()
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
    
    func filteredModel() -> [DetailItemModel] {
       let rezult =  model.items.filter({$0.isFavorite == true})
        return rezult
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
        return filteredModel().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = filteredElements[indexPath.row]
            cell.text = item.content
            cell.date = item.dateCreation
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoritesTapped = { [weak self] in
                self?.filteredElements[indexPath.row].isFavorite.toggle()
                //FIX BUG. ADD REMOVE SYSTEM
//                StorageManager.shared.addPictureFavoriteStatus(model: item)
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
