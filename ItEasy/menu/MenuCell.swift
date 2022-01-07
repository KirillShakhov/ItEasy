//
//  MenuCell.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var selectButton: UIButton!
	
	var menu: MenuModel.Menu?
	
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuImage: RecipeCardImage!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuSelectButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
		
        selectButton.layer.cornerRadius = 10
		
    }
    @IBAction func selectMenu(_ sender: Any) {
        
    }
}
