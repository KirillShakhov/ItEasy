//
//  TableViewCell.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 05.01.2022.
//

import UIKit

class IngredientCell: UITableViewCell {
    @IBOutlet weak var ingredientCount: UILabel!
	@IBOutlet weak var ingredientName: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
