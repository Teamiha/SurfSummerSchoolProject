//
//  FavoriteCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 07.08.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants

    private enum Constants {
        static let fillHeartImage = UIImage(named: "heart-fill")
        static let heartImage = UIImage(named: "heart")
    }
    
    // MARK: - Views
    
    @IBOutlet private weak var favoriteImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var favoriteTitle: UILabel!
    @IBOutlet private weak var favoriteDate: UILabel!
    @IBOutlet private weak var favoriteText: UILabel!
    
    // MARK: - Events

    var didFavoritesTapped: (() -> Void)?

    // MARK: - Calculated
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }
    
    // MARK: - Properties

    var image: UIImage? {
        didSet {
            favoriteImage.image = image
        }
    }
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    var title: String = "" {
        didSet {
            favoriteTitle.text = title
        }
    }
    var date: String = "" {
        didSet {
            favoriteDate.text = date
        }
    }
    var text: String = "" {
        didSet {
            favoriteText.text = text
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction private func favoriteAction(_ sender: UIButton) {
        didFavoritesTapped?()
        isFavorite.toggle()
    }
    
    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
        
    }

}

// MARK: - Private Methods

private extension FavoriteCollectionViewCell {
    
    func configureAppearance() {
        favoriteTitle.textColor = .black
        favoriteText.font = .systemFont(ofSize: 12)
        
        favoriteImage.layer.cornerRadius = 12
        
        favoriteButton.tintColor = .white
        
        favoriteDate.font = .systemFont(ofSize: 10)
        favoriteDate.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        
    }
    
}
