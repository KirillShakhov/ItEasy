//
//  ShadowView.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.gray.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		self.layer.shadowRadius = 5.0
		self.layer.shadowOpacity = 1.0
		self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
	}
}
