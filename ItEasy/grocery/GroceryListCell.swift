//
//  GroceryListCell.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 06.01.2022.
//

import UIKit

class GroceryListCell: UITableViewCell {
	var ingridient: RecipeModel.Ingredients?
	
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.name.text = ingridient?.product.name
        self.count.text = ingridient?.count
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
