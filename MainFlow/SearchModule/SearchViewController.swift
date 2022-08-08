//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 04.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.tabBarController?.tabBar.isHidden = true

    }

    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    


}



// MARK: - Private Methods

private extension SearchViewController {
    func configureNavigationBar() {
        navigationItem.title = "Поиск"
        let backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
}
