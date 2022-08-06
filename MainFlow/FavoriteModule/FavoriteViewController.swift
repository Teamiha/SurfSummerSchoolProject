//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - NavigationController
        
        let searchButton = UIBarButtonItem(
            image: UIImage(named: "searchButton"),
            style: .plain,
            target: self,
            action: #selector(moveToSearch)
            )
        
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.title = "Избранное"
    }

    
    
    @objc func moveToSearch() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
