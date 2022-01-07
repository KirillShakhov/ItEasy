//
//  RecipeCardViewController.swift
//  ItEasy
//
//  Created by Кирилл Шахов on 04.01.2022.
//

import UIKit

class RecipeCard: UIViewController {
	
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cookingTime: UILabel!
    
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var carbohydrates: UILabel!
    
    @IBOutlet weak var kcal: UILabel!
    
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
    
    
	var recipe: RecipeModel.Recipe?
    
	override func viewDidLoad() {
        super.viewDidLoad()
		
        ingredientTable.dataSource = self
        ingredientTable.delegate = self

		cardTitle.text = recipe?.name
		kcal.text = String(format: "%.1f", recipe!.kcal)
		cookingTime.text = recipe?.cookingTime
		proteins.text = String(format: "%.1f", recipe!.proteins)+" гр"
		fats.text = String(format: "%.1f", recipe!.fats)+" гр"
		carbohydrates.text = String(format: "%.1f", recipe!.carbohydrates)+" гр"

		recipe = RecipeModel.getRecipeInfo(id: (recipe!.id))
		print()

		print(recipe ?? "Null")
		if(recipe != nil){
			DispatchQueue.global().async {
				if let data = try? Data(contentsOf: URL(string: self.recipe?.image ?? "")!) {
					if let image = UIImage(data: data) {
						DispatchQueue.main.async {
							self.cardImage.image = image
							self.activityIndicator.isHidden = true
						}
					}
				}
			}
		}
		
		ingredientTable.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")

    }
	
	
	@IBAction func closeCard(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}

    @IBAction func cook(_ sender: Any) {
		let storyboard = UIStoryboard(name: "RecipeSteps", bundle: nil)
		guard let vc = storyboard.instantiateViewController(identifier: "RecipeSteps") as? RecipeSteps else { return }
		vc.recipe = recipe
		vc.modalPresentationStyle = .popover
		present(vc, animated:true)

    }
}


extension RecipeCard: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RecipeCard: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipe?.ingredients?.count ?? 0
	}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTable.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
		cell.ingredientName.text = recipe!.ingredients![indexPath.item].product.name
		cell.ingredientCount.text = recipe!.ingredients![indexPath.item].count
		return cell
    }
}
