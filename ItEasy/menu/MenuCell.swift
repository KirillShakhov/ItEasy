//
//  MenuCell.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuImage: RecipeCardImage!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuSelectButton: UIButton!
	
	var menuList: MenuList!

	var menu: MenuModel.Menu?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
        selectButton.layer.cornerRadius = 10
		
    }
    @IBAction func selectMenu(_ sender: Any) {
		print("click")
		if(menu != nil){
			if(MenuList.selectMenu(id: menu!.id)){
                selectButton.setTitle("Selected", for: .normal)
                selectButton.backgroundColor = UIColor.clear
				menuList.updateMenus(self)
			}else{
				print("Не выбрано")
			}
		}
    }
}
