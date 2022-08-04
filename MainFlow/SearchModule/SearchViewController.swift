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

        // Do any additional setup after loading the view.
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
