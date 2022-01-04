//
//  GradientButton.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 03.01.2022.
//

import Foundation
import UIKit

@IBDesignable
class ActualGradientButton: UIButton {

	@IBInspectable var firstColor: UIColor = UIColor.clear {
		didSet {
			updateColors()
		}
	}
	@IBInspectable var secondColor: UIColor = UIColor.clear {
		didSet {
			updateColors()
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
		layer.cornerRadius = 15
		layer.masksToBounds = true
	}

	private lazy var gradientLayer: CAGradientLayer = {
		let l = CAGradientLayer()
		l.frame = self.bounds
		l.colors = [firstColor.cgColor, secondColor.cgColor]
		l.startPoint = CGPoint(x: 0, y: 0)
		l.endPoint = CGPoint(x: 1, y: 1)
		l.cornerRadius = 15
		layer.insertSublayer(l, at: 0)
		return l
	}()
	
	func updateColors(){
		let l = CAGradientLayer()
		l.frame = self.bounds
		l.colors = [firstColor.cgColor, secondColor.cgColor]
		l.startPoint = CGPoint(x: 0, y: 0)
		l.endPoint = CGPoint(x: 3, y: 3)
		l.cornerRadius = 15
		layer.insertSublayer(l, at: 0)
		l.frame.size = self.frame.size

		gradientLayer = l
		layoutSubviews()
	}
}
