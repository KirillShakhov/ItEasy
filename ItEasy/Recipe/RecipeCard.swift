//
//  RecipeCardViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecipeCard: UIViewController {
	
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    var itemName: String?
    var itemImage: UIImage?

    
	override func viewDidLoad() {
        super.viewDidLoad()
        cardTitle.text = itemName
		cardImage.image = itemImage
    }
	
	
	@IBAction func closeCard(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}

}
