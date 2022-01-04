//
//  RecipeCardViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecipeCard: UIViewController {
	
    @IBOutlet var cardTitle: UILabel!
    var itemName: String?

    
	override func viewDidLoad() {
        super.viewDidLoad()
        cardTitle.text = itemName
    }
	
	
	@IBAction func closeCard(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}

}
