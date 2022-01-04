//
//  RecipeCardImage.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

@IBDesignable
class RecipeCardImage: UIImageView {
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = 20
		self.clipsToBounds = true
	}
}
