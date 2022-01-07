//
//  RecieptViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit


class RecieptViewController: UIViewController {
	@IBOutlet var recipeView: UIView!
	private let refreshControl = UIRefreshControl()

    @IBOutlet weak var recipeList: UICollectionView!
	
    @IBOutlet weak var findField: UITextField!
    
    
	var recipes: [RecipeModel.Recipe] = []
    

	override func viewDidLoad() {
        super.viewDidLoad()
		
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
		recipeView.addGestureRecognizer(panGesture)
	
		self.recipeList.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCell")

		self.recipeList.dataSource = self
		self.recipeList.delegate = self
		
		recipes = RecipeModel.getRecipes()
		
		refreshControl.layer.zPosition = -1
		recipeList.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(updateRecipes(_:)), for: .valueChanged)
		
		refreshControl.tintColor = UIColor(red:0.25, green:0.85, blue:0.25, alpha:0.6)
		refreshControl.attributedTitle = NSAttributedString(string: "Update Recipes ...")

    }
	@objc private func updateRecipes(_ sender: Any) {
		if(findField.text == nil || findField.text == ""){
			recipes = RecipeModel.getRecipes()
		}else{
			recipes = RecipeModel.getRecipes(find: findField.text!)
		}
		self.refreshControl.endRefreshing()
		recipeList.reloadData()
		print("Updated")
	}
    
	@objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
		recipeView.endEditing(true)
	}
    
	@IBAction func find() {
		print(findField.text ?? "")
		dismissKeyboard()
		updateRecipes(self)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
    
}

extension RecieptViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
		let recipe = recipes[indexPath.item]
		
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
