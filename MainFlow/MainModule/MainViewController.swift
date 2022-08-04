//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    
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
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

//MARK: - Private Methods

private extension MainViewController {
    
    func configureApperance() {
        collectionView.dataSource = self
    }
    
    func configurateModel() {
        model.didItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
