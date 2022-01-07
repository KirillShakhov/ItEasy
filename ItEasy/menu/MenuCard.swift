//
//  MenuCard.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 07.01.2022.
//

import UIKit

class MenuCard: UIViewController {
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuList: UICollectionView!
    @IBOutlet weak var menuDescription: UITextView!
    @IBOutlet weak var menuButtonSelect: UIButton!
	
	var menu: MenuModel.Menu?
	
	private var recipes = [RecipeModel.Recipe]()
    override func viewDidLoad() {
        super.viewDidLoad()
		self.menuList.dataSource = self
		self.menuList.delegate = self
		self.menuList.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")
		
		menu = MenuModel.getMenuInfo(id: menu!.id)
		
		menuName.text = menu?.name
		menuDescription.text = menu?.description
		
		
		recipes.append(contentsOf: menu?.monday ?? [])
		recipes.append(contentsOf: menu?.tuesday ?? [])
		recipes.append(contentsOf: menu?.wednesday ?? [])
		recipes.append(contentsOf: menu?.thursday ?? [])
		recipes.append(contentsOf: menu?.friday ?? [])
		recipes.append(contentsOf: menu?.saturday ?? [])
		recipes.append(contentsOf: menu?.sunday ?? [])
    }
    
    @IBAction func selectMenu() {
        
    }
}

extension MenuCard: UICollectionViewDelegate{
	
}

extension MenuCard: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recipes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let recipe = recipes[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		cell.title.text = recipe.name
		cell.kcal.text = String(format: "%.1f", recipe.kcal)
		cell.image.image = nil
		cell.activityIndicator.isHidden = false
		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: URL(string: recipe.image)!) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						cell.image.image = image
						cell.activityIndicator.isHidden = true
					}
				}
			}
		}
		cell.layer.shadowColor = UIColor.gray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		cell.layer.shadowRadius = 5.0
		cell.layer.shadowOpacity = 1.0
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
	}
	
	
}
