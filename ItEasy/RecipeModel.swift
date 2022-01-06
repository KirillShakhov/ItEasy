//
//  RecipeModel.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import Foundation
import UIKit

class RecipeModel{
	static let locationNames = ["Olive", "Оливье", "Оливье", "Оливье", "Оливье"]
	   
	static let locationImages = [UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive"), UIImage(named: "olive")]

	static func getLocationNames() -> [String] {
		return RecipeModel.locationNames
	}
	
	static func getLocationImages() -> [UIImage?] {
		return RecipeModel.locationImages
	}
}
