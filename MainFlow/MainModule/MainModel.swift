//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 04.08.2022.
//

import Foundation
import UIKit

final class MainModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    
    var items: [ItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    //MARK: - Methods
    
    func getPosts() {
        items = Array(repeating: ItemModel.createDefault(), count: 100)
    }
    
}

struct ItemModel {
    let image: UIImage?
    let title: String
    let isFavorite: Bool
    let dateCreation: String
    let content: String
    
    static func createDefault() -> ItemModel {
        .init(image: UIImage(named: "default-image"), title: "Самый милый корги", isFavorite: false, dateCreation: "04.08.2022", content: "Эта порода относится к семейству овчарок, поэтому о вельш-корги пемброк говорят, что это большая собака в маленьком теле. Рост корги обычно не превышает 30 сантиметров в холке, а вес колеблется от 12 до 15 килограммов. Продолжительность жизни составляет 12-15 лет.")
    }
    
}
