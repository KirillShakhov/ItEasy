//
//  RecipeCardViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecipeCard: UIViewController {
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	
	@IBAction func closeCard(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}

	
}
