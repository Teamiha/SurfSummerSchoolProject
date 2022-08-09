//
//  FavoriteModel.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 08.08.2022.
//

import Foundation
import UIKit

final class FavoriteModel {

    // MARK: - Events

    var didItemsUpdated: (() -> Void)?

    // MARK: - Properties

    var items: [TestModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }

    // MARK: - Methods

    func getPosts() {
        items = Array(repeating: TestModel.createDefault(), count: 100)
    }

}
