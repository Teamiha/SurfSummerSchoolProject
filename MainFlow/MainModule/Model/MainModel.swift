//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 04.08.2022.
//

import Foundation
import UIKit

final class MainModel {

    // MARK: - Events

    var didItemsUpdated: (() -> Void)?
    
    var errorStateIsTrue = false
    
    // MARK: - Properties

    let pictureService = PicturesService()
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }

    // MARK: - Methods

    func loadPosts() {
        pictureService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: StorageManager.shared.checkIfElementFavorite(id: pictureModel.id),
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
            case .failure(_):
                self?.errorStateIsTrue = true
            }
        }
    }

}



