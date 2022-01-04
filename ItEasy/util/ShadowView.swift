//
//  ShadowView.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

	@IBInspectable var cornerRadius: CGFloat = 20
	@IBInspectable var shadowRadius: CGFloat = 5.0

	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = cornerRadius
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.gray.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		self.layer.shadowRadius = shadowRadius
		self.layer.shadowOpacity = 1.0
		self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
	}
}
