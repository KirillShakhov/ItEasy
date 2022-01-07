//
//  RecipeCell.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecipeCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var kcal: UILabel!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var imageURL:String?
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.masksToBounds = true
		self.layer.shadowOffset = CGSize(width: 0, height: 0)
		self.layer.shadowRadius = 0
		self.layer.shadowOpacity = 0
	}
}
