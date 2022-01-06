//
//  RecieptViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit


class RecieptViewController: UIViewController {
    @IBOutlet weak var recipeList: UICollectionView!
	
	var recipes: [Recipes.Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
	
		self.recipeList.register(UINib(nibName: "RecieptCell", bundle: nil), forCellWithReuseIdentifier: "RecieptCell")

		self.recipeList.dataSource = self
		self.recipeList.delegate = self
		
		recipes = Recipes.getRecipes()
		print(recipes)
		
        // Do any additional setup after loading the view.
    }
}

extension RecieptViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecieptCell", for: indexPath) as! RecieptCell
		let recipe = recipes[indexPath.item]
		
		cell.title.text = recipe.name
		cell.kcal.text = String(format: "%f", recipe.kcal)
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

extension RecieptViewController: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recipes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let recipe = recipes[indexPath.item]
		
		let storyboard = UIStoryboard(name: "RecipeCard", bundle: nil)
		guard let vc = storyboard.instantiateViewController(identifier: "RecipeCard") as? RecipeCard else { return }
		
		vc.recipe = recipe

		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: URL(string: recipe.image)!) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						vc.cardImage.image = image
					}
				}
			}
		}
		
		
//		let vc = storyboard.instantiateViewController(withIdentifier: "RecipeCard")
		vc.modalPresentationStyle = .fullScreen
		
//		self.navigationController?.pushViewController(vc, animated: true)
		present(vc, animated:true)
		
	}
}
