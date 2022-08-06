//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 04.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "BackArrow")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "Поиск"

    }




}
